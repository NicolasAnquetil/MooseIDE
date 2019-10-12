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
	(mockApp stub displayFocus: Any) will: [ :args | displayUpdated := args].

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
	(mockApp stub displayFocus: Any) will: [ displayUpdated := true].

	displayUpdated := false.
	entitiesCtxt focusBeHierarchical.
	self assert: displayUpdated.

	displayUpdated := false.
	entitiesCtxt focusBeFlat.
	self assert: displayUpdated.
]

{ #category : #tests }
TestCtxtEntities >> testFlattenWhenFrozen [
	| displayed |
	displayed := #().
	(mockApp stub displayFocus: Any) will: [ :args | displayed := args].

	entitiesCtxt focusBeHierarchical.
	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1 . #ancestor1 -> #child2}).

	self assert: displayed size equals: 1.
	self assert: displayed first equals: #ancestor1.

	displayed := #().
	entitiesCtxt freeze.

	entitiesCtxt focusBeFlat.

	self assert: displayed size equals: 2.
	self assert: displayed first name equals: 'child1'.
	self assert: displayed second name equals: 'child2'
]

{ #category : #tests }
TestCtxtEntities >> testFlattenWithSelection [
	| selected |
	selected := #().
	(mockApp stub selectPaths: Any) will: [ :args | selected := args].

	entitiesCtxt focusBeHierarchical.
	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1}).

	entitiesCtxt freeze.

	entitiesCtxt userSelection: #(#(1 1)).
	self assert: selected size equals: 1.
	self assert: selected first equals: #(1 1).

	selected := #().
	entitiesCtxt focusBeFlat.

	self assert: selected size equals: 1.
	self assert: selected first equals: #(1).

]

{ #category : #tests }
TestCtxtEntities >> testFrozen [
	| displayed selected |
	displayed := #().
	selected  := #().
	(mockApp stub displayFocus: Any) will: [ :args | displayed := args].
	(mockApp stub selectPaths: Any)  will: [ :args | selected := args].

	launcherCtxt midasFocus: (MidasEntityFamix with: #anEntity ancestor: #anAncestor).
	self assert: displayed size equals: 1.
	self assert: selected size equals: 0.

	entitiesCtxt freeze.

	displayed := #().
	launcherCtxt midasFocus: (MidasEntityFamix with: #anEntity ancestor: #anAncestor).
	self assert: displayed size equals: 0.
	self assert: selected size equals: 1.

]

{ #category : #tests }
TestCtxtEntities >> testNotFrozen [
	| displayUpdated |
	(mockApp stub displayFocus: Any) will: [ displayUpdated := true].

	entitiesCtxt unfreeze.
	displayUpdated := false.
	launcherCtxt midasFocus: (MidasEntityFamix with: #anEntity ancestor: #anAncestor).
	self assert: displayUpdated 
]

{ #category : #tests }
TestCtxtEntities >> testSelectionResultAsTree [
	| selection |
	selection := #().
	(mockApp stub selectPaths: Any) will: [ :arg | selection := arg ].

	entitiesCtxt focusBeHierarchical.
	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1 . #ancestor1 -> #child2}).

	entitiesCtxt userSelection: #(#(1 2)).
	self assert: selection size equals: 1.
	self assert: selection first equals: #(1 2).

	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1 . #ancestor1 -> #child2}).

	entitiesCtxt userSelection: #(#(1)).
	self assert: selection size equals: 2.
	self assert: selection first equals: #(1 1).
	self assert: selection second equals: #(1 2).
]

{ #category : #tests }
TestCtxtEntities >> testSelectionResultFlatten [
	| selection |
	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1 . #ancestor1 -> #child2}).

	entitiesCtxt focusBeFlat.
	
	(mockApp stub selectPaths: Any) will: [ :arg | selection := arg ].

	entitiesCtxt userSelection: #(#(2)).

	self assert: selection size equals: 1.
	self assert: selection first equals: #(2)
]
