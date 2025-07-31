from planonto import PlanPopulator, DomainGenerator




# Create test planning domain and populate it
pop = PlanPopulator()

domain = pop.create_domain("hanoi")
pop.add_requirement_to_domain(domain, "STRIPS")

clear = pop.add_predicate_to_domain(domain, "clear")
on = pop.add_predicate_to_domain(domain, "on")
smaller = pop.add_predicate_to_domain(domain, "smaller")

action = pop.add_action_to_domain(domain, "move")

disc = pop.add_parameter_to_action(action, "disc")
from_ = pop.add_parameter_to_action(action, "from")
to = pop.add_parameter_to_action(action, "to")

pop.add_precondition_to_action(action, {'name': '', 'elements': [smaller, disc, to]})
pop.add_precondition_to_action(action, {'name': '', 'elements': [on, disc, from_]})
pop.add_precondition_to_action(action, {'name': '', 'elements': [clear, disc]})
pop.add_precondition_to_action(action, {'name': '', 'elements': [clear, to]})

pop.add_effect_to_action(action, {'name': '', 'elements': [clear, from_]})
pop.add_effect_to_action(action, {'name': '', 'elements': [on, disc, to]}) # NOT ?
pop.add_effect_to_action(action, {'name': '', 'elements': [on, disc, from_]})
pop.add_effect_to_action(action, {'name': '', 'elements': [clear, to]}) # NOT ?

pop.save()


gen = DomainGenerator()
prob = gen.generate_test_domain("robot_domain")
gen.export_pddl(prob)