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
TestCtxtEntities >> testCheckResultAsTree [
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
TestCtxtEntities >> testSelectionResultAsTree [
	| focus |
	entitiesCtxt trackAssociation.

	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1 . #ancestor1 -> #child2}).

	
	(mockApp stub updateMidasFocus: Any) will: [ :arg | focus := arg ].

	entitiesCtxt userSelection: #(#(1 2)).
	self assert: focus size equals: 1.
	self assert: focus first equals: #ancestor1.
	self assert: (entitiesCtxt childrenFor: #ancestor1) size equals: 1.
	self assert: (entitiesCtxt childrenFor: #ancestor1) first name equals:	'child2'
]

{ #category : #tests }
TestCtxtEntities >> testSelectionResultFlatten [
	| focus |
	focus := {(#ancestor1 -> #(child1 child2))}.
	launcherCtxt midasFocus: (MidasEntityFamixCollection with: focus).

	entitiesCtxt flattenResult.
	
	(mockApp stub updateMidasFocus: Any) will: [ :arg | focus := arg ].
	entitiesCtxt userSelection: #(#(2)).
	self assert: focus size equals: 1.
	self assert: focus first equals: #child2
]
