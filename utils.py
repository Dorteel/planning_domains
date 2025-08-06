from rdflib import Graph, Namespace, RDF, RDFS
import logging
from owlready2 import *
from owlready2 import get_ontology, onto_path
from unified_planning.shortcuts import *
from unified_planning.io import PDDLWriter
from unified_planning.io import PDDLReader
from pathlib import Path

# Set up logging
logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s [%(levelname)s]: %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S'
                    )

class OntoPlanConverter:
    def __init__(self, ontology_dir="planonto/models", ontology_file="plan-ontology-rdf.owl"):
        self.ontology_dir = ontology_dir
        self.ontology_file = ontology_file
        onto_path.append(self.ontology_dir)
        self.onto = get_ontology(ontology_file).load()

        # Aliases to common classes, assuming they exist in ontology
        self.PlanningDomain = self.onto.search_one(iri="*#PlanningDomain")
        self.DomainAction = self.onto.search_one(iri="*#DomainAction")
        self.DomainPredicate = self.onto.search_one(iri="*#DomainPredicate")
        self.DomainRequirement = self.onto.search_one(iri="*#DomainRequirement")
        self.ActionPrecondition = self.onto.search_one(iri="*#ActionPrecondition")
        self.ActionEffect = self.onto.search_one(iri="*#ActionEffect")
        self.Parameter = self.onto.search_one(iri="*#ActionParameter")

        self.hasAction = self.onto.search_one(iri="*#hasAction")
        self.hasPredicate = self.onto.search_one(iri="*#hasPredicate")
        self.hasRequirement = self.onto.search_one(iri="*#hasRequirement")
        self.hasPrecondition = self.onto.search_one(iri="*#hasActionPrecondition")
        logging.debug(f"self.Parameter: {self.Parameter}")
        logging.debug(f"self.DomainAction: {self.DomainAction}")
        logging.debug(f"self.PlanningDomain: {self.PlanningDomain}")
        logging.debug(f"self.DomainPredicate: {self.DomainPredicate}")
        logging.debug(f"self.hasAction: {self.hasAction}")
        if not all([self.PlanningDomain, self.DomainAction, self.hasAction]):
            print("Warning: Some expected ontology classes/properties not found. Check your OWL file.")


    def _print_up_problem(self, problem):
        print("== Problem Name ==")
        print(f"Problem name: {problem.name}\n")
        print(f"Problem type: {problem.kind}\n")

        print("== Requirements ==")
        for feature in problem.kind.features:
            print(f"  {feature}")

        print("== Types ==")
        for t in problem.user_types:
            print(f"  {t} (Parent: {t.father if t.father else 'None'})")
        print()
        
        print("== Objects ==")
        for t in problem.user_types:
            for obj in problem.objects(t.name):
                print(f"  {obj.name} : {obj.type}")
        print()
        
        print("== Fluents ==")
        for fl in problem.fluents:
            print(f"  {fl.name}({', '.join(str(p) for p in fl.signature)}) : {fl.type}")
        print()
        
        print("== Actions ==")
        for act in problem.actions:
            print(f"  {act.name}({', '.join(str(p) for p in act.parameters)})")
            print("    Preconditions:")
            if hasattr(act, 'preconditions'):
                for pre in act.preconditions:
                    print(f"      {pre}")
            if hasattr(act, 'effects'):
                print("    Effects:")
                for eff in act.effects:
                    print(f"      {eff}")
            print()
        
        print("== Initial Values ==")
        for fl, val in problem.initial_values.items():
            print(f"  {fl} = {val}")
        print()
        
        print("== Goals ==")
        for g in problem.goals:
            print(f"  {g}")
        print()

    def _print_onto_classes_and_instances(self):
        print("== Ontology Classes and Instances ==")
        for cls in self.onto.classes():
            print(f"Class: {cls.name}")
            instances = list(cls.instances())
            if instances:
                for inst in instances:
                    print(f"  - Instance: {inst.name}")
            else:
                print("  (no instances)")
        print("== End ==")

    def create_domain(self, name):
        domain = self.PlanningDomain(name)
        print(f"Created PlanningDomain: {domain.name}")
        return domain

    def add_action_to_domain(self, domain, action_name):
        action = self.DomainAction(action_name)
        domain.hasAction.append(action)
        print(f"Added DomainAction to {domain.name} '{action_name}'")
        return action

    def add_predicate_to_domain(self, domain, predicate_name):
        predicate = self.DomainPredicate(predicate_name)
        domain.hasPredicate.append(predicate)
        print(f"Added DomainPredicate to {domain.name} '{predicate_name}'")
        return predicate

    def add_precondition_to_action(self, action, precondition_name):
        precondition = self.ActionPrecondition(precondition_name)
        action.hasPrecondition.append(precondition)
        print(f"Added ActionPrecondition to {action.name} '{precondition_name}'")
        return precondition

    def add_effect_to_action(self, action, effect_name):
        effect = self.ActionEffect(effect_name)
        action.hasEffect.append(effect)
        print(f"Added Effect to {action.name} '{effect_name}'")
        return effect

    def add_parameter_to_action(self, action, parameter_name):
        parameter = self.Parameter(parameter_name)
        action.hasParameter.append(parameter)
        print(f"Added Parameter to {action.name}'{parameter_name}'")
        return parameter

    def add_requirement_to_domain(self, domain, requirement_name):
        requirement = self.DomainRequirement(requirement_name)
        domain.hasRequirement.append(requirement)
        print(f"Added DomainRequirement to {domain.name} '{requirement_name}'")
        return requirement

    def save(self, filename="planonto/models/ontoviplan/test-output.owl"):
        self.onto.save(file=filename, format="rdfxml")
        print(f"Ontology saved to {filename}")

    def convert_pddl2onto(self, domain_filename=None, problem_filename=None, save_path=None):
        reader = PDDLReader()
        problem = reader.parse_problem(domain_filename, problem_filename)
        domain = self.create_domain(problem.name)
        self.add_requirement_to_domain(domain, 'strips')
        for predicate in problem.fluents:
            self.add_predicate_to_domain(domain, str(predicate))
        # self._print_up_problem(problem)
        for action in problem.actions:
            action_onto = self.add_action_to_domain(domain, action.name)
            for param in action.parameters:
                self.add_parameter_to_action(action_onto, param.name)
            for effect in action.effects:
                effect_desc = f"{effect.fluent} := {effect.value}"
                self.add_effect_to_action(action_onto, effect_desc)
            for precondition in action.preconditions:
                self.add_precondition_to_action(action_onto, precondition)
        # Save ontology
        if save_path:
            self.save(save_path)
        return problem

    def convert_onto2uniproblem(self):
        pass

    def read_ontology(self, ontology_dir='test/domains/output_domains/', ontology_file="hanoi_planonto.owl"):
        # Read the ontology
        self.ontology_dir = ontology_dir
        onto_path.append(self.ontology_dir)
        self.onto = get_ontology(ontology_file).load()
        self._print_onto_classes_and_instances()

    def convert_onto2pddl(self, problem: Problem, domain_name="test_domain.pddl", problem_name="test_problem.pddl"):
        
        writer = PDDLWriter(problem)
        domain_path = self.save_path + problem_name
        problem_path = self.save_path + domain_name
        writer.write_domain(domain_path)
        # writer.write_problem(problem_path)
        print(f"Wrote domain to: {domain_path}")
        # print(f"Wrote problem to: {problem_path}")

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
        print(prompt)
        print("\n---\n")

if __name__ == "__main__":
    converter = OntoPlanConverter()
    input_name = 'hanoi_domain.pddl'
    output_name = 'hanoi_planonto.owl'
    input_path = Path('test/domains/input_domains/') / input_name
    output_path = Path('test/domains/output_domains/') / output_name
    problem = converter.convert_pddl2onto(domain_filename=str(input_path), save_path=str(output_path))
    converter.read_ontology()