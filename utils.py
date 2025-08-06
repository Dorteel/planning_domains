from rdflib import Graph, Namespace, RDF, RDFS
import logging
from owlready2 import *
from owlready2 import get_ontology, onto_path
from unified_planning.shortcuts import *
from unified_planning.io import PDDLWriter
from unified_planning.io import PDDLReader
from pathlib import Path
from sentence_transformers import SentenceTransformer, util
from rdflib import Graph, Namespace
import urllib.parse

# Set up logging
logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s [%(levelname)s]: %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S'
                    )

class PlanOnto4UniPlan:
    def __init__(self, ontology_dir="planonto/models", ontology_file="plan-ontology-rdf.owl"):
        self.ontology_dir = ontology_dir
        self.ontology_file = ontology_file
        onto_path.append(self.ontology_dir)
        self.onto = get_ontology(ontology_file).load()

        # Aliases to common classes, assuming they exist in ontology
        self.PlanningDomain = self.onto.search_one(iri="*#PlanningDomain")
        self.DomainAction = self.onto.search_one(iri="*#DomainAction")
        self.DomainPredicate = self.onto.search_one(iri="*#DomainPredicate")
        self.DomainPredicateType = self.onto.search_one(iri="*#DomainPredicateType")
        self.DomainPredicateParameter = self.onto.search_one(iri="*#DomainPredicateParameter")
        self.DomainRequirement = self.onto.search_one(iri="*#DomainRequirement")
        self.ActionPrecondition = self.onto.search_one(iri="*#ActionPrecondition")
        self.ActionEffect = self.onto.search_one(iri="*#ActionEffect")
        self.ActionParameter = self.onto.search_one(iri="*#ActionParameter")
        self.AssignmentEffect = self.onto.search_one(iri="*#AssignmentEffect")
        # Aliases to common object types
        self.object = self.onto.search_one(iri="*#object")

        # Add connectives
        self.And = self.onto.And
        self.Or = self.onto.Or
        self.Not = self.onto.Not
        self.AtomicFormula = self.onto.search_one(iri="*#AtomicFormula")

        # Add predicates
        self.hasAction = self.onto.search_one(iri="*#hasAction")
        self.hasPredicate = self.onto.search_one(iri="*#hasPredicate")
        self.hasRequirement = self.onto.search_one(iri="*#hasRequirement")
        self.hasPrecondition = self.onto.search_one(iri="*#hasActionPrecondition")
        self.hasDomainPredicateName = self.onto.search_one(iri="*#hasDomainPredicateName")
        self.hasDomainPredicateType = self.onto.search_one(iri="*#hasDomainPredicateType")
        self.hasDomainPredicateParameter = self.onto.search_one(iri="*#hasDomainPredicateType")
        self.belongsToDomain = self.onto.search_one(iri="*#belongsToDomain")
        self.belongsToAction = self.onto.search_one(iri="*#belongsToAction")
        # Utility variables
        self.predicate_lookups = {}
        self.param_lookups = {}

        # Add types
        self.types = {}
        TypeClass = self.onto.search_one(iri="*#Type")
        if TypeClass is None:
            logging.warning("Type class not found in ontology.")
        else:
            for t in TypeClass.subclasses():
                self.types[t.name] = t
            logging.info(f"Loaded planning types: {list(self.types.keys())}")
        logging.debug(f"self.ActionParameter: {self.ActionParameter}")
        logging.debug(f"self.DomainAction: {self.DomainAction}")
        logging.debug(f"self.PlanningDomain: {self.PlanningDomain}")
        logging.debug(f"self.DomainPredicate: {self.DomainPredicate}")
        logging.debug(f"self.hasAction: {self.hasAction}")
        if not all([self.PlanningDomain, self.DomainAction, self.hasAction]):
            logging.info("Warning: Some expected ontology classes/properties not found. Check your OWL file.")


    # ==================================
    # Debugging functions
    # ----------------------------------

    def _print_up_problem(self, problem):
        logging.info("== Problem Name ==")
        logging.info(f"Problem name: {problem.name}\n")
        logging.info(f"Problem type: {problem.kind}\n")

        logging.info("== Requirements ==")
        for feature in problem.kind.features:
            logging.info(f"  {feature}")

        logging.info("== Types ==")
        for t in problem.user_types:
            logging.info(f"  {t} (Parent: {t.father if t.father else 'None'})")
        logging.info()
        
        logging.info("== Objects ==")
        for t in problem.user_types:
            for obj in problem.objects(t.name):
                logging.info(f"  {obj.name} : {obj.type}")
        logging.info()
        
        logging.info("== Fluents ==")
        for fl in problem.fluents:
            logging.info(f"  {fl.name}({', '.join(str(p) for p in fl.signature)}) : {fl.type}")
        logging.info()
        
        logging.info("== Actions ==")
        for act in problem.actions:
            logging.info(f"  {act.name}({', '.join(str(p) for p in act.parameters)})")
            logging.info("    Preconditions:")
            if hasattr(act, 'preconditions'):
                for pre in act.preconditions:
                    logging.info(f"      {pre}")
            if hasattr(act, 'effects'):
                logging.info("    Effects:")
                for eff in act.effects:
                    logging.info(f"      {eff}")
            logging.info()
        
        logging.info("== Initial Values ==")
        for fl, val in problem.initial_values.items():
            logging.info(f"  {fl} = {val}")
        logging.info()
        
        logging.info("== Goals ==")
        for g in problem.goals:
            logging.info(f"  {g}")
        logging.info()

    def _print_onto_classes_and_instances(self):
        logging.info("== Ontology Classes and Instances ==")
        for cls in self.onto.classes():
            logging.info(f"Class: {cls.name}")
            instances = list(cls.instances())
            if instances:
                for inst in instances:
                    logging.info(f"  - Instance: {inst.name}")
            else:
                logging.info("  (no instances)")
        logging.info("== End ==")

    def _print_predicate_info(self, predicate):
        print("Fluent:")
        print(f"  Name: {predicate.name}")
        print(f"  Type: {predicate.type}")
        print(f"  Parameters: {predicate.signature}")  # dict of param_name: type
        print(f"  Arity: {predicate.arity}")
        print(f"  Default initial value: {getattr(predicate, 'default_initial_value', None)}")
        print("-" * 40)

    def _print_precondition_info(self, expr, indent=0):
        prefix = "  " * indent
        print(f"{prefix}{type(expr).__name__}: {expr}")
        if hasattr(expr, "args") and expr.args:
            for arg in expr.args:
                self._print_precondition_info(arg, indent + 1)

    def _print_effect(self, effect, indent=0):
        prefix = "  " * indent
        if hasattr(effect, "fluent"):
            fluent = effect.fluent() if callable(effect.fluent) else effect.fluent
            # Drill down to underlying Fluent object
            if hasattr(fluent, "fluent"):
                inner_fluent = fluent.fluent() if callable(fluent.fluent) else fluent.fluent
                fluent_name = inner_fluent.name
                fluent_args = fluent.args
                print(f"{prefix}{fluent_name}({', '.join(str(arg) for arg in fluent_args)}) := {effect.value}")
            else:
                print(f"{prefix}Unknown fluent structure: {fluent}")
        elif hasattr(effect, "condition"):
            print(f"{prefix}when (")
            self.print_formula(effect.condition, indent + 1)
            print(f"{prefix}) do (")
            self._print_effect(effect.effect, indent + 1)
            print(f"{prefix})")
        else:
            print(f"{prefix}Unknown effect type: {type(effect)}")

    def _print_effects_of_action(self, action):
        print(f"Effects for action: {action.name}")
        for effect in getattr(action, "effects", []):
            self._print_effect(effect, indent=1)

    # ==================================
    # PDDL -> PlanOnto Parsing Functions
    # ----------------------------------

    def create_domain(self, name):
        domain = self.PlanningDomain(name)
        logging.info(f"Created PlanningDomain: {domain.name}")
        return domain

    def add_action_to_domain(self, domain, action_name):
        action = self.DomainAction(action_name)
        domain.hasAction.append(action)
        logging.info(f"Added DomainAction to {domain.name} '{action_name}'")
        return action

    def add_parameters_to_predicate(self, predicate, parameters):
        for i in range(len(parameters)):
            param_type, param_name = str(parameters[i]).split(' ')
            p = self.DomainPredicateParameter(param_name)
            if param_type in self.types:
                self.types[param_type](param_name)
            else:
                logging.warning(f"Unknown type: {param_type}")
            p.hasPredicateParameterIndex.append(i)
            predicate.hasDomainPredicateParameter.append(p)
            logging.info(f"Added DomainPredicateParameter to {predicate} '{p}'")

    def add_predicate_to_domain(self, domain, predicate):
        domainpredicate = self.DomainPredicate(predicate.name)
        domainpredicate.label = [locstr(str(predicate.name), lang="en")]
        domainPredicateType = self.DomainPredicateType(predicate.type)
        domain.hasPredicate.append(domainpredicate)
        domainpredicate.hasDomainPredicateType.append(domainPredicateType)
        self.add_parameters_to_predicate(domainpredicate, predicate.signature)
        logging.info(f"Added DomainPredicate to {domain.name} '{predicate.name}'")
        return domainpredicate

    def add_precondition_to_action(self, action, formula, predicate_lookup, param_lookup):
        precondition_indiv = self.ActionPrecondition(self.clean_iri(f"{action.name}_precondition"))
        action.hasPrecondition.append(precondition_indiv)
        root_formula_node = self.formula_to_ontology(formula, predicate_lookup, param_lookup)
        precondition_indiv.hasRootNode.append(root_formula_node)
        precondition_indiv.label = [locstr(str(formula), lang="en")]
        logging.info(f"Added ActionPrecondition to {action.name} '{formula}'")
        return precondition_indiv

    def add_effect_to_action(self, action_onto, effects, predicate_lookup, param_lookup):
        effect_inds = []
        for effect in effects:
            effect_node = self.formula_to_ontology(effect, predicate_lookup, param_lookup)
            action_effect = self.ActionEffect()
            action_effect.hasRootNode.append(effect_node)
            action_onto.hasEffect.append(action_effect)
            action_effect.label = [locstr(str(effect), lang="en")]
            logging.info(f"Added Effect to {action_onto} '{effect}'")
            effect_inds.append(action_effect)
        return effect_inds

    def add_parameter_to_action(self, action, parameter_name):
        parameter = self.ActionParameter(parameter_name)
        action.hasParameter.append(parameter)
        logging.info(f"Added Parameter to {action.name}'{parameter_name}'")
        return parameter

    def add_requirement_to_domain(self, domain, requirement_name):
        requirement = self.DomainRequirement(requirement_name)
        domain.hasRequirement.append(requirement)
        logging.info(f"Added DomainRequirement to {domain.name} '{requirement_name}'")
        return requirement

    def formula_to_ontology(self, formula, predicate_lookup, param_lookup):
        if hasattr(formula, "fluent") and hasattr(formula, "value"):
            # Effect object, not just FNode!
            fluent = formula.fluent() if callable(formula.fluent) else formula.fluent
            inner_fluent = fluent.fluent() if hasattr(fluent, "fluent") and callable(fluent.fluent) else getattr(fluent, "fluent", fluent)
            pred_name = inner_fluent.name
            fluent_args = [param_lookup[str(arg)] for arg in fluent.args]
            value = formula.value
            assignment_effect = self.AssignmentEffect()
            assignment_effect.assignsFluent.append(predicate_lookup[pred_name])
            assignment_effect.hasArgument = fluent_args
            assignment_effect.assignsValue.append(self.up_value_to_python(value))
            assignment_effect.label = [locstr(f"{pred_name}({', '.join(str(a) for a in fluent.args)}) := {value}", lang="en")]
            return assignment_effect
 
        if formula.is_and():
            and_node = self.And()
            and_node.hasArgument = [
                self.formula_to_ontology(child, predicate_lookup, param_lookup)
                for child in formula.args
            ]
            return and_node
        elif formula.is_or():
            or_node = self.Or()
            or_node.hasArgument = [
                self.formula_to_ontology(child, predicate_lookup, param_lookup)
                for child in formula.args
            ]
            return or_node
        elif formula.is_not():
            not_node = self.Not()
            not_node.hasArgument = [
                self.formula_to_ontology(formula.args[0], predicate_lookup, param_lookup)
            ]
            return not_node
        elif hasattr(formula, "fluent"):
            pred = formula.fluent() if callable(formula.fluent) else formula.fluent
            if hasattr(pred, "name"):
                pred_name = pred.name
                atomic_node = self.AtomicFormula()
                atomic_node.label = [locstr(str(formula), lang="en")]
                atomic_node.refersToPredicate.append(predicate_lookup[pred_name])
                atomic_node.hasArgument = [param_lookup[str(arg)] for arg in formula.args]
                return atomic_node
            else:
                raise NotImplementedError(
                    f"Expected Fluent for atomic formula, got {type(pred)} ({repr(pred)})"
                )
        else:
            raise NotImplementedError(
                f"Unsupported formula node: {formula} (class: {formula.__class__}, content: {repr(formula)})"
            )

    # ====================
    # Utility Functions
    # --------------------
    def up_value_to_python(self, value):
        # Unified Planning FNode for constant? Use .constant_value() if available.
        # Otherwise, just pass through.
        if hasattr(value, "is_bool_constant") and value.is_bool_constant():
            return bool(value.constant_value())
        elif hasattr(value, "constant_value"):
            # For numbers
            return value.constant_value()
        elif isinstance(value, (bool, int, float, str)):
            return value
        else:
            raise ValueError(f"Cannot convert UP value '{value}' ({type(value)}) to a Python literal for OWL.")

        
    
    def save(self, filename="planonto/models/ontoviplan/test-output.owl"):
        self.onto.save(file=filename, format="rdfxml")
        logging.info(f"Ontology saved to {filename}")

    def read_ontology(self, ontology_dir='test/domains/output_domains/', ontology_file="hanoi_planonto.owl"):
        # Read the ontology
        self.ontology_dir = ontology_dir
        onto_path.append(self.ontology_dir)
        self.onto = get_ontology(ontology_file).load()
        self._print_onto_classes_and_instances()

    def reconstruct_iri(self, cleaned: str) -> str:
        """
        Reverses the process from clean_iri.
        """
        return urllib.parse.unquote(str(cleaned))

    def clean_iri(self, name: str) -> str:
        """
        Converts the full IRI into a readable but reconstructable format.
        Uses percent-encoding for the fragment.
        """
        return urllib.parse.quote(str(name), safe='')

    def mark_instances_with_domain(self, domain_instance, source_file ='unknown'):
        """
        Annotate all relevant instances with the belongsToDomain property.
        """
        # List the classes you want to annotate
        relevant_classes = [
            self.DomainAction,
            self.DomainPredicate,
            self.DomainPredicateParameter,
            self.ActionParameter,
            self.ActionEffect,
            self.ActionPrecondition,
            self.AtomicFormula,
            self.object
        ]
        for cls in relevant_classes:
            for inst in cls.instances():
                if domain_instance not in inst.belongsToDomain:
                    inst.belongsToDomain.append(domain_instance)
                    inst.comment = [f'Created from file: {source_file}']

    # ====================
    # OntoViPlan Functions
    # --------------------

    def add_pddl2onto(self, domain_filename=None, problem_filename=None, save_path=None):
        reader = PDDLReader()
        problem = reader.parse_problem(domain_filename, problem_filename)
        domain = self.create_domain(problem.name)
        self.add_requirement_to_domain(domain, 'strips')
        pred_lookup = {}
        for predicate in problem.fluents:
            predicate_indiv = self.add_predicate_to_domain(domain, predicate)
            pred_lookup[predicate.name] = predicate_indiv
        # Prepare param lookups for this domain
        self.param_lookups[problem.name] = {}
        self.predicate_lookups[problem.name] = pred_lookup

        for action in problem.actions:
            action_onto = self.add_action_to_domain(domain, action.name)
            # Build param_lookup for this action
            param_lookup = {}
            for param in action.parameters:
                param_indiv = self.add_parameter_to_action(action_onto, param.name)
                param_lookup[param.name] = param_indiv
            # Store param_lookup for this domain+action
            self.param_lookups[problem.name][action.name] = param_lookup
            # self._print_effects_of_action(action)
            # for effect in action.effects:
            #     effect_desc = f"{effect.fluent} := {effect.value}"
            self.add_effect_to_action(action_onto, action.effects, pred_lookup, param_lookup)
            for precondition in action.preconditions:
                # self._print_precondition_info(precondition)
                # Use the lookups here!
                self.add_precondition_to_action(
                    action_onto,
                    precondition,
                    predicate_lookup=self.predicate_lookups[problem.name],
                    param_lookup=self.param_lookups[problem.name][action.name]
                )
        self.mark_instances_with_domain(domain, source_file=domain_filename)
        if save_path:
            self.save(save_path)
        return problem

    def convert_domain2uniproblem(self):
        pass

    def query_all_domain_descriptions(self):
        pass

    def query_domain_details(self):
        pass

    def select_matching_domain(self, instruction, model='all-MiniLM-L6-v2'):
        model = SentenceTransformer('all-MiniLM-L6-v2')
        domain_descriptions = None
        instruction_embedding = model.encode(instruction, convert_to_tensor=True)
        domain_description_embeddings = model.encode(domain_descriptions, convert_to_tensor=True)
        cosine_scores = util.cos_sim(instruction_embedding, domain_description_embeddings)
        most_similar_idx = cosine_scores.argmax()
        selected_domain = domain_description_embeddings[most_similar_idx]
        logging.info(f"Found most similar domain: {selected_domain}")
        return selected_domain

    def convert_onto2pddl(self, problem: Problem, domain_name="test_domain.pddl", problem_name="test_problem.pddl"):
        
        writer = PDDLWriter(problem)
        domain_path = self.save_path + problem_name
        writer.write_domain(domain_path)  
        logging.info(f"Wrote domain to: {domain_path}")
        # problem_path = self.save_path + domain_name
        # writer.write_problem(problem_path)
        # logging.info(f"Wrote problem to: {problem_path}")

    def domain_generator(self, instruction):
        logging.info(f"Generating domain for instruction: {instruction}")
        selected_domain = self.select_matching_domain(instruction)
        problem = self.convert_domain2uniproblem(selected_domain)
        self.convert_onto2pddl(problem)

class PromptConstructor:
    def __init__(self, ontology_path):
        self.graph = Graph()
        self.graph.parse(ontology_path)
        self.ns = Namespace("http://example.org/ontology.owl#")
        self.logger = logging.getLogger(__name__)
        self.logger.info(f"Ontology loaded from {ontology_path} with {len(self.graph)} triples.")

    def construct_prompt(self):
        prompts = []

        # query = """
        # PREFIX : <http://example.org/ontology.owl#>
        # SELECT ?scenario ?task ?desc ?obj ?super
        # WHERE {
        #     ?scenario a :Scenario .
        #     ?scenario :involvesObject ?obj .
        #     ?obj a ?super .
        #     ?task a :Task .
        #     OPTIONAL { ?task :hasDescription ?desc }
        # }
        # """
        query = """
        PREFIX : <http://example.org/ontology.owl#>
        SELECT ?scenario ?task ?desc ?obj ?super
        WHERE {
            ?scenario a :Scenario .
        }
        """
        self.logger.debug(f"Executing SPARQL query: {query}")
        results = self.graph.query(query)
        self.logger.info(f"Query returned {len(results)} results.")
        scenario_map = {}

        for row in results:
            scenario_uri = row['scenario']
            task_uri = row['task']
            desc = str(row['desc']) if row['desc'] else "No description provided"
            obj_uri = row['obj']
            super_uri = row['super']

            scenario_name = scenario_uri.split("#")[-1]
            task_name = task_uri.split("#")[-1]
            obj_name = obj_uri.split("#")[-1]
            super_name = super_uri.split("#")[-1]

            if scenario_name not in scenario_map:
                scenario_map[scenario_name] = {
                    'task': task_name,
                    'description': desc,
                    'objects': []
                }

            scenario_map[scenario_name]['objects'].append((obj_name, super_name))

        for scenario, info in scenario_map.items():
            object_lines = [f"        {obj} - {superc}" for obj, superc in info['objects']]

            prompt = f"""
            I want you to solve a planning problem for {info['task']}.
            You need to:
            {info['description']}

            An example of a planning problem definition is:
            (define (problem {scenario})
                (:domain {info['task']})
                (:objects
            {chr(10).join(object_lines)}
                )
            )
            """
            prompts.append(prompt.strip())

        return prompts


#=======================
# Testing functions
#-----------------------

def test_prompts():
    constructor = PromptConstructor("ontology.owl")
    generated_prompts = constructor.construct_prompt()
    for prompt in generated_prompts:
        logging.info(prompt)
        logging.info("\n---\n")

def query_action_parameters(owl_path, domain_name):
    g = Graph()
    g.parse(owl_path)
    ns = Namespace("http://example.org/ontology.owl#")
    
    query = f"""
    PREFIX : <http://example.org/ontology.owl#>
    SELECT ?action ?param
    WHERE {{
        ?domain a :PlanningDomain ;
                :hasAction ?action .
        ?action :hasParameter ?param .
        FILTER(strends(str(?domain), "#{domain_name}"))
    }}
    """
    for row in g.query(query):
        action_uri = row['action']
        param_uri = row['param']
        print(f"Action: {action_uri}, Parameter: {param_uri}")

if __name__ == "__main__":
    converter = PlanOnto4UniPlan()
    input_name = 'hanoi_domain.pddl'
    output_name = 'hanoi_planonto.owl'
    input_path = Path('test/domains/input_domains/') / input_name
    output_path = Path('test/domains/output_domains/') / output_name
    problem = converter.add_pddl2onto(domain_filename=str(input_path), save_path=str(output_path))
    converter.read_ontology()
    # query_action_parameters("test/domains/output_domains/hanoi_planonto.owl", "hanoi")