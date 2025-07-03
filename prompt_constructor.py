from rdflib import Graph, Namespace, RDF, RDFS

class PromptConstructor:
    def __init__(self, ontology_path):
        self.graph = Graph()
        self.graph.parse(ontology_path)
        self.ns = Namespace("http://example.org/ontology.owl#")

    def construct_prompt(self):
        prompts = []

        query = """
        PREFIX : <http://example.org/ontology.owl#>
        SELECT ?scenario ?task ?desc ?obj ?super
        WHERE {
            ?scenario a :Scenario .
            ?scenario :involvesObject ?obj .
            ?obj a ?super .
            ?task a :Task .
            OPTIONAL { ?task :hasDescription ?desc }
        }
        """

        results = self.graph.query(query)

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

if __name__ == "__main__":
    constructor = PromptConstructor("ontology.owl")
    generated_prompts = constructor.construct_prompt()
    for prompt in generated_prompts:
        print(prompt)
        print("\n---\n")
