Class {
	#name : #TestCtxtEntities,
	#superclass : #AbstractTestMidasCtxt,
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
TestCtxtEntities >> testBypassFreeze [
	| displayUpdated |
	(mockApp stub updateMidasFocus: Any) will: [ :args | displayUpdated := args].

	entitiesCtxt freeze.
	displayUpdated := #().
	launcherCtxt midasFocus: (MidasEntityFamix with: #anEntity ancestor: #anAncestor).
	self assert: displayUpdated isEmpty.

	entitiesCtxt bypassFreeze.
	self assert: displayUpdated size equals: 1.
	self assert: displayUpdated first equals: #anEntity
]

{ #category : #tests }
TestCtxtEntities >> testCheckResultAsTree [
	| displayUpdated |
	(mockApp stub updateMidasFocus: Any) will: [ displayUpdated := true].

	displayUpdated := false.
	entitiesCtxt focusBeHierarchical.
	self assert: displayUpdated.

	displayUpdated := false.
	entitiesCtxt focusBeFlat.
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
	| selection |
	(mockApp stub selectPaths: Any) will: [ :arg | selection := arg ].

	entitiesCtxt focusBeHierarchical.
	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1 . #ancestor1 -> #child2}).

	entitiesCtxt userSelection: #(#(1 2)).
	self assert: selection equals: #(#(1 2)) asOrderedCollection.

	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1 . #ancestor1 -> #child2}).

	entitiesCtxt userSelection: #(#(1)).
	self assert: selection equals: #(#(1 1) #(1 2)) asOrderedCollection
]

{ #category : #tests }
TestCtxtEntities >> testSelectionResultFlatten [
	| selection |
	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1 . #ancestor1 -> #child2}).

	entitiesCtxt focusBeFlat.
	
	(mockApp stub selectPaths: Any) will: [ :arg | selection := arg ].

	entitiesCtxt userSelection: #(#(2)).

	self assert: selection equals: #(#(2)) asOrderedCollection
]
