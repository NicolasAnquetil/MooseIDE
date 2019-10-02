Class {
	#name : #TestCtxtEntities,
	#superclass : #TestMidasCtxt,
	#instVars : [
		'entitiesCtxt'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestCtxtEntities >> setUp [
	super setUp.
	entitiesCtxt := launcherCtxt spawn: MidasContextEntities.
	entitiesCtxt app: self mockEmptyApp.
]

{ #category : #tests }
TestCtxtEntities >> testChekResultAsTree [
	| displayUpdated |
	(mockApp stub updateMidasFocus: Any) will: [ displayUpdated := true].

	displayUpdated := false.
	entitiesCtxt trackAssociation.
	self assert: displayUpdated.

	displayUpdated := false.
	entitiesCtxt flattenResult.
	self assert: displayUpdated.
]

{ #category : #tests }
TestCtxtEntities >> testFilterQuery [
	mockApp stub filterQuery willReturn: true.

	entitiesCtxt midasFocus:
		(MidasEntityFamixCollection with: {
			#ancestor1 -> #(child11 child12) .
			#ancestor2 -> #(child21 child22 child23) }).
	entitiesCtxt interpretQuery: 'each asString endsWith: ''2'''.

	self assert: entitiesCtxt midasFocus size equals: 2.
	self assert: entitiesCtxt midasFocus entities first  equals: #child12.
	self assert: entitiesCtxt midasFocus entities second equals: #child22.	
]

{ #category : #tests }
TestCtxtEntities >> testFrozen [
	| displayUpdated |
	(mockApp stub updateMidasFocus: Any) will: [ displayUpdated := true].

	entitiesCtxt freeze.
	displayUpdated := false.
	launcherCtxt midasFocus: (MidasEntityFamix with: #anEntity ancestor: #anAncestor).
	self deny: displayUpdated 
]

{ #category : #tests }
TestCtxtEntities >> testNotFrozen [
	| displayUpdated |
	(mockApp stub updateMidasFocus: Any) will: [ displayUpdated := true].

	entitiesCtxt unfreeze.
	displayUpdated := false.
	launcherCtxt midasFocus: (MidasEntityFamix with: #anEntity ancestor: #anAncestor).
	self assert: displayUpdated 
]

{ #category : #tests }
TestCtxtEntities >> testScopeClasses [
	entitiesCtxt midasFocus: (MidasEntityFamix with: (self someNamespaces anyOne) ancestor: #anAncestor).
	entitiesCtxt classScope.
	self assert: entitiesCtxt midasFocus size equals: 2.
	entitiesCtxt midasFocus entities do: [ :each | self assert: each isClass ]
]

{ #category : #tests }
TestCtxtEntities >> testScopeMethods [
	entitiesCtxt midasFocus: (MidasEntityFamixCollection with: { #anAncestor -> self someClasses}).
	entitiesCtxt methodScope.
	self assert: entitiesCtxt midasFocus size equals: 1.
	self assert: entitiesCtxt midasFocus entities anyOne name equals: 'methodA1'

]

{ #category : #tests }
TestCtxtEntities >> testScopePackage [
	entitiesCtxt midasFocus:
		(MidasEntityFamixCollection with: {
			#anAncestor -> {
				models second entityNamed: 'aNamespace::ClassA' .
				models second entityNamed: 'aNamespace::ClassB'}}).
	entitiesCtxt packageScope.
	self assert: entitiesCtxt midasFocus size equals: 2.
	self assert: entitiesCtxt midasFocus entities first  name equals: 'aPackage'.
	self assert: entitiesCtxt midasFocus entities second name equals: 'anotherPackage'

]

{ #category : #tests }
TestCtxtEntities >> testSelectionFrozen [
	| displayUpdated |
	(mockApp stub updateMidasFocus: Any) will: [ displayUpdated := true].
	launcherCtxt midasFocus: 
			(MidasEntityFamixCollection with: { #ancestor1 -> #(child1 child2) }).

	entitiesCtxt selectionNoFocus.

	displayUpdated := false.
	entitiesCtxt userSelection: #( #(1) ).
	self deny: displayUpdated.

	displayUpdated := false.
	entitiesCtxt focusOnSelection: #( #(2) ).
	self assert: displayUpdated.

]

{ #category : #tests }
TestCtxtEntities >> testSelectionNotFrozen [
	| displayUpdated |
	(mockApp stub updateMidasFocus: Any) will: [ displayUpdated := true].
	launcherCtxt midasFocus: 
			(MidasEntityFamixCollection with: { #ancestor1 -> #(child1 child2) }).

	entitiesCtxt selectionToFocus.

	displayUpdated := false.
	entitiesCtxt userSelection: #( #(1) ).

	self assert: displayUpdated 
]

{ #category : #tests }
TestCtxtEntities >> testSelectionResultAsTree [
	| focus |
	focus := {(#ancestor1 -> #(child1 child2))}.
	launcherCtxt midasFocus: (MidasEntityFamixCollection with: focus).
	
	entitiesCtxt selectionToFocus.
	entitiesCtxt trackAssociation.
	
	(mockApp stub updateMidasFocus: Any) will: [ :arg | focus := arg ].
	entitiesCtxt userSelection: #(#(1 2)).
	self assert: focus size equals: 1.
	self assert: focus first equals: #ancestor1->#(#child2)
]

{ #category : #tests }
TestCtxtEntities >> testSelectionResultFlatten [
	| focus |
	focus := {(#ancestor1 -> #(child1 child2))}.
	launcherCtxt midasFocus: (MidasEntityFamixCollection with: focus).
	
	entitiesCtxt selectionToFocus.
	entitiesCtxt flattenResult.
	
	(mockApp stub updateMidasFocus: Any) will: [ :arg | focus := arg ].
	entitiesCtxt userSelection: #(#(2)).
	self assert: focus size equals: 1.
	self assert: focus first equals: #child2
]
