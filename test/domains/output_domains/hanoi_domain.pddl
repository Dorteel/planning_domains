<?xml version="1.0"?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
         xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
         xmlns:owl="http://www.w3.org/2002/07/owl#"
         xml:base="https://purl.org/ai4s/ontology/planning"
         xmlns="https://purl.org/ai4s/ontology/planning#"
         xmlns:term="http://purl.org/dc/terms/">

<owl:Ontology rdf:about="https://purl.org/ai4s/ontology/planning">
  <owl:versionIRI rdf:resource="https://purl.org/ai4s/ontology/planning/v2.0"/>
  <term:contributor rdf:datatype="http://www.w3.org/2001/XMLSchema#string">Bharath Muppasani, Vishal Pallagani, Biplav Srivastava, Raghava Mutharaju</term:contributor>
  <term:creator rdf:datatype="http://www.w3.org/2001/XMLSchema#string">Bharath Muppasani</term:creator>
  <term:description rdf:datatype="http://www.w3.org/2001/XMLSchema#string">This ontology represents the knowledge about automated planning domain. It captures the characteristics, features, and performance of different planners and domains, as well as the relationships between them. The ontology can be used to select suitable planners for a given domain and to improve their performance. The ontology aims to facilitate automated planning research and applications.</term:description>
  <term:language rdf:datatype="http://www.w3.org/2001/XMLSchema#string">English</term:language>
  <term:license rdf:datatype="http://www.w3.org/2001/XMLSchema#string">https://creativecommons.org/licenses/by/4.0/legalcode</term:license>
  <term:title rdf:datatype="http://www.w3.org/2001/XMLSchema#string">Ontology to model Automated Planning domain</term:title>
  <rdfs:seeAlso rdf:datatype="http://www.w3.org/2001/XMLSchema#string">https://github.com/BharathMuppasani/AI-Planning-Ontology</rdfs:seeAlso>
  <owl:versionInfo rdf:datatype="http://www.w3.org/2001/XMLSchema#decimal">2.0</owl:versionInfo>
</owl:Ontology>

<owl:ObjectProperty rdf:about="#addsPredicate">
  <rdfs:domain rdf:resource="#ActionEffect"/>
  <rdfs:range rdf:resource="#State"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates an effect to a state that adds a predicate to it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#deletesPredicate">
  <rdfs:domain rdf:resource="#ActionEffect"/>
  <rdfs:range rdf:resource="#State"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates an effect to a state that deletes a predicate from it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasAction">
  <rdfs:domain rdf:resource="#PlanningDomain"/>
  <rdfs:range rdf:resource="#DomainAction"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning domain to a domain action that is available in it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasConstant">
  <rdfs:domain rdf:resource="#PlanningDomain"/>
  <rdfs:range rdf:resource="#DomainConstant"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning domain to a domain constant that is defined in it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasEffect">
  <rdfs:domain rdf:resource="#DomainAction"/>
  <rdfs:range rdf:resource="#ActionEffect"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates an action to an action effect that results from it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasExtractedAction">
  <rdfs:domain rdf:resource="#PlanningDomain"/>
  <rdfs:range rdf:resource="#MacroAction"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning domain to an action that is extracted from its plan</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasGoalState">
  <rdfs:domain rdf:resource="#PlanningProblem"/>
  <rdfs:range rdf:resource="#GoalState"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning problem to a goal state that is desired for it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasHighRelevancePlanner">
  <rdfs:domain rdf:resource="#PlanningDomain"/>
  <rdfs:range rdf:resource="#Planner"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning domain to a planner that has a high relevance score for it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasInitialState">
  <rdfs:domain rdf:resource="#PlanningProblem"/>
  <rdfs:range rdf:resource="#InitialState"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning problem to an initial state that is given for it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasLowRelevancePlanner">
  <rdfs:domain rdf:resource="#PlanningDomain"/>
  <rdfs:range rdf:resource="#Planner"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning domain to a planner that has a low relevance score for it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasMediumRelevancePlanner">
  <rdfs:domain rdf:resource="#PlanningDomain"/>
  <rdfs:range rdf:resource="#Planner"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning domain to a planner that has a medium relevance score for it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasObject">
  <rdfs:domain rdf:resource="#PlanningProblem"/>
  <rdfs:range rdf:resource="#ProblemObject"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning problem to a problem object that is involved in it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasParameter">
  <rdfs:domain rdf:resource="#DomainAction"/>
  <rdfs:range rdf:resource="#ActionParameter"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates an action to an action parameter that is involved in it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasPlan">
  <rdfs:domain rdf:resource="#PlanningProblem"/>
  <rdfs:range rdf:resource="#Plan"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning problem to a plan that solves it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasPrecondition">
  <rdfs:domain rdf:resource="#DomainAction"/>
  <rdfs:range rdf:resource="#ActionPrecondition"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates an action to an action precondition that is required for it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasPredicate">
  <rdfs:domain rdf:resource="#PlanningDomain"/>
  <rdfs:range rdf:resource="#DomainPredicate"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning domain to a domain predicate that is defined in it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasProblem">
  <rdfs:domain rdf:resource="#PlanningDomain"/>
  <rdfs:range rdf:resource="#PlanningProblem"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning domain to a planning problem that is defined in it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasRequirement">
  <rdfs:domain rdf:resource="#PlanningDomain"/>
  <rdfs:range rdf:resource="#DomainRequirement"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning domain or problem to a domain requirement that is required or supported by it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasTag">
  <rdfs:domain rdf:resource="#Type"/>
  <rdfs:range rdf:resource="#TypeTag"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a type to a type tag that labels it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasType">
  <rdfs:domain rdf:resource="#PlanningDomain"/>
  <rdfs:range rdf:resource="#Type"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planning domain to a type</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#hasTypeInstance">
  <rdfs:domain rdf:resource="#Type"/>
  <rdfs:range rdf:resource="#ProblemObject"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a type to a problem object that is an instance of it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#isGeneratedBy">
  <rdfs:domain rdf:resource="#Plan"/>
  <rdfs:range rdf:resource="#Planner"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a plan to a planner that generates it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#ofPlannerType">
  <rdfs:domain rdf:resource="#Planner"/>
  <rdfs:range rdf:resource="#PlannerType"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a planner to a planner type that categorizes it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#ofType">
  <rdfs:domain rdf:resource="#ActionParameter"/>
  <rdfs:range rdf:resource="#Type"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates an action parameter to a type that classifies it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#solvedBy">
  <owl:inverseOf rdf:resource="#solvesRequirement"/>
  <rdfs:domain rdf:resource="#DomainRequirement"/>
  <rdfs:range rdf:resource="#Planner"/>
  <rdfs:comment rdf:datatype="http://www.w3.org/2001/XMLSchema#string">a property that relates a domain requirement to a planner that solves it</rdfs:comment>
</owl:ObjectProperty>

<owl:ObjectProperty rdf:about="#solvesRequirement">
  <rdfs:domain rdf:resource="#Planner"/>
  <rdfs:range rdf:resource="#DomainRequirement"/>
  <rdfs:comment xml:lang="en">a property that relates a planner to a domain requirement that it can handle or satisfy</rdfs:comment>
</owl:ObjectProperty>

<owl:DatatypeProperty rdf:about="#hasPlanCost">
  <rdfs:domain rdf:resource="#Plan"/>
  <rdfs:range rdf:resource="http://www.w3.org/2001/XMLSchema#nonNegativeInteger"/>
</owl:DatatypeProperty>

<owl:AnnotationProperty rdf:about="http://purl.org/dc/terms/contributor"/>

<owl:AnnotationProperty rdf:about="http://purl.org/dc/terms/creator"/>

<owl:AnnotationProperty rdf:about="http://purl.org/dc/terms/description"/>

<owl:AnnotationProperty rdf:about="http://purl.org/dc/terms/language"/>

<owl:AnnotationProperty rdf:about="http://purl.org/dc/terms/license"/>

<owl:AnnotationProperty rdf:about="http://purl.org/dc/terms/title"/>

<owl:AnnotationProperty rdf:about="#Authors"/>

<owl:Class rdf:about="#ActionEffect">
  <rdfs:comment xml:lang="en">a class that represents what happens after an action is done</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#State">
  <rdfs:comment xml:lang="en">represents a situation or a configuration of the world in a planning problem</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#PlanningDomain">
  <rdfs:subClassOf>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#hasAction"/>
      <owl:someValuesFrom rdf:resource="#DomainAction"/>
    </owl:Restriction>
  </rdfs:subClassOf>
  <rdfs:subClassOf>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#hasPredicate"/>
      <owl:someValuesFrom rdf:resource="#DomainPredicate"/>
    </owl:Restriction>
  </rdfs:subClassOf>
  <rdfs:subClassOf>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#hasRequirement"/>
      <owl:someValuesFrom rdf:resource="#DomainRequirement"/>
    </owl:Restriction>
  </rdfs:subClassOf>
  <rdfs:comment xml:lang="en">a class that represents a problem setting for automated planning</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#DomainAction">
  <rdfs:subClassOf>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#hasEffect"/>
      <owl:someValuesFrom rdf:resource="#ActionEffect"/>
    </owl:Restriction>
  </rdfs:subClassOf>
  <rdfs:comment xml:lang="en">a class that represents a type of action that can be performed in a planning domain</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#DomainConstant">
  <rdfs:comment xml:lang="en">represents a fixed entity in a planning domain</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#MacroAction">
  <rdfs:subClassOf rdf:resource="#DomainAction"/>
  <rdfs:comment xml:lang="en">Extracted macro action, which is a combination of multiple actions of a planning domain</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#PlanningProblem">
  <rdfs:subClassOf>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#hasGoalState"/>
      <owl:someValuesFrom rdf:resource="#GoalState"/>
    </owl:Restriction>
  </rdfs:subClassOf>
  <rdfs:subClassOf>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#hasInitialState"/>
      <owl:someValuesFrom rdf:resource="#InitialState"/>
    </owl:Restriction>
  </rdfs:subClassOf>
  <rdfs:subClassOf>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#hasObject"/>
      <owl:someValuesFrom rdf:resource="#ProblemObject"/>
    </owl:Restriction>
  </rdfs:subClassOf>
  <rdfs:comment xml:lang="en">represents a task of the planning domain that requires a plan to be solved</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#GoalState">
  <rdfs:subClassOf rdf:resource="#State"/>
  <rdfs:comment xml:lang="en">represents a desired or a target state defined in a task that a plan should achieve</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#Planner">
  <rdfs:subClassOf>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#ofPlannerType"/>
      <owl:someValuesFrom rdf:resource="#PlannerType"/>
    </owl:Restriction>
  </rdfs:subClassOf>
  <rdfs:subClassOf>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#solvesRequirement"/>
      <owl:someValuesFrom rdf:resource="#DomainRequirement"/>
    </owl:Restriction>
  </rdfs:subClassOf>
  <rdfs:comment xml:lang="en">a system that can generate plans for a given planning domain and problem</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#InitialState">
  <rdfs:subClassOf rdf:resource="#State"/>
  <rdfs:comment xml:lang="en">represents the starting or the given state of a planning problem</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#ProblemObject">
  <rdfs:comment xml:lang="en">represents an entity or a constant that is involved in a planning problem</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#ActionParameter">
  <rdfs:comment xml:lang="en">a class that represents what is involved in an action</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#Plan">
  <rdfs:subClassOf>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#hasPlanCost"/>
      <owl:someValuesFrom rdf:resource="http://www.w3.org/2001/XMLSchema#nonNegativeInteger"/>
    </owl:Restriction>
  </rdfs:subClassOf>
</owl:Class>

<owl:Class rdf:about="#ActionPrecondition">
  <rdfs:comment xml:lang="en">a class that represents what needs to be true before an action can be done</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#DomainPredicate">
  <rdfs:comment xml:lang="en">a class that represents a condition or a fact that can be true or false in a planning domain</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#DomainRequirement">
  <rdfs:comment xml:lang="en">A feature that a planning domain requires or supports</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#Type">
  <rdfs:subClassOf rdf:resource="#TypeTag"/>
  <rdfs:comment xml:lang="en">represents a kind of entity in a planning domain</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#TypeTag">
  <rdfs:comment xml:lang="en">represents a label that can be assigned to a type in a planning domain</rdfs:comment>
</owl:Class>

<owl:Class rdf:about="#PlannerType">
  <rdfs:comment xml:lang="en">a category or classification of planners based on their characteristics or features</rdfs:comment>
</owl:Class>

<owl:NamedIndividual rdf:about="#hanoi">
  <rdf:type rdf:resource="#PlanningDomain"/>
  <hasRequirement rdf:resource="#strips"/>
  <hasAction rdf:resource="#move"/>
</owl:NamedIndividual>

<owl:NamedIndividual rdf:about="#strips">
  <rdf:type rdf:resource="#DomainRequirement"/>
</owl:NamedIndividual>

<owl:NamedIndividual rdf:about="#move">
  <rdf:type rdf:resource="#DomainAction"/>
  <hasParameter rdf:resource="#disc"/>
  <hasParameter rdf:resource="#from"/>
  <hasParameter rdf:resource="#to"/>
  <hasEffect rdf:resource="#clear(from) := true"/>
  <hasEffect rdf:resource="#on(disc, to) := true"/>
  <hasEffect rdf:resource="#on(disc, from) := false"/>
  <hasEffect rdf:resource="#clear(to) := false"/>
</owl:NamedIndividual>

<owl:NamedIndividual rdf:about="#disc">
  <rdf:type rdf:resource="#ActionParameter"/>
</owl:NamedIndividual>

<owl:NamedIndividual rdf:about="#from">
  <rdf:type rdf:resource="#ActionParameter"/>
</owl:NamedIndividual>

<owl:NamedIndividual rdf:about="#to">
  <rdf:type rdf:resource="#ActionParameter"/>
</owl:NamedIndividual>

<owl:NamedIndividual rdf:about="#clear(from) := true">
  <rdf:type rdf:resource="#ActionEffect"/>
</owl:NamedIndividual>

<owl:NamedIndividual rdf:about="#on(disc, to) := true">
  <rdf:type rdf:resource="#ActionEffect"/>
</owl:NamedIndividual>

<owl:NamedIndividual rdf:about="#on(disc, from) := false">
  <rdf:type rdf:resource="#ActionEffect"/>
</owl:NamedIndividual>

<owl:NamedIndividual rdf:about="#clear(to) := false">
  <rdf:type rdf:resource="#ActionEffect"/>
</owl:NamedIndividual>


</rdf:RDF>
