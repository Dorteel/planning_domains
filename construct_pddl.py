from unified_planning.io import PDDLWriter
from unified_planning.shortcuts import *

# ========================
# DOMAIN FILE
#-------------------------
# Declaring types
Location = UserType("Location")

# Creating problem ‘variables’
robot_at = Fluent("robot_at", BoolType(), location=Location)
battery_charge = Fluent("battery_charge", RealType(0, 100))

# Creating actions
move = InstantaneousAction("move", l_from=Location, l_to=Location)
l_from = move.parameter("l_from")
l_to = move.parameter("l_to")
move.add_precondition(GE(battery_charge, 10))
move.add_precondition(robot_at(l_from))
move.add_precondition(Not(robot_at(l_to)))
move.add_effect(robot_at(l_from), False)
move.add_effect(robot_at(l_to), True)
move.add_effect(battery_charge, Minus(battery_charge, 10))

# ========================
# PROBLEM FILE
#-------------------------
# Declaring objects
l1 = Object("l1", Location)
l2 = Object("l2", Location)

# Populating the problem with initial state and goals
problem = Problem("robot")
problem.add_fluent(robot_at)
problem.add_fluent(battery_charge)
problem.add_action(move)
problem.add_object(l1)
problem.add_object(l2)
problem.set_initial_value(robot_at(l1), True)
problem.set_initial_value(robot_at(l2), False)
problem.set_initial_value(battery_charge, 100)
problem.add_goal(robot_at(l2))

writer = PDDLWriter(problem)
# domain_filename = ... # Path to file where the PDDL domain will be printed.
writer.write_domain('test_domain.pddl')
# problem_filename = ... # Path to file where the PDDL problem will be printed.
writer.write_problem('test_problem.pddl')