Class {
	#name : #TestCtxtHistory,
	#superclass : #TestMidasCtxt,
	#instVars : [
		'historyCtxt'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestCtxtHistory >> setUp [
	super setUp.
	historyCtxt := launcherCtxt spawn: MidasContextHistory.
	historyCtxt app: self mockEmptyApp.
]

{ #category : #tests }
TestCtxtHistory >> testEntriesBranchingCount [
	self assert: historyCtxt allEntries size equals: 1.
	self assert: historyCtxt history firstEntry nextEntries size equals: 0.
	historyCtxt midasFocus: (MidasEntityFamixCollection with: { #anAncestor -> #(child1 child2) }).
	self assert: historyCtxt allEntries size equals: 2.
	self assert: historyCtxt history firstEntry nextEntries size equals: 1.
	historyCtxt prev.
	historyCtxt midasFocus: (MidasEntityFamixCollection with: { #anAncestor -> #(other1 other2 other3) }).
	self assert: historyCtxt allEntries size equals: 3.
	self assert: historyCtxt history firstEntry nextEntries size equals: 2.

]

{ #category : #tests }
TestCtxtHistory >> testEntriesCount [
	self assert: historyCtxt allEntries size equals: 1.
	historyCtxt midasFocus: (MidasEntityFamixCollection with: { #anAncestor -> #(child1 child2) }).
	self assert: historyCtxt allEntries size equals: 2.
	historyCtxt midasFocus: (MidasEntityFamixCollection with: { #anAncestor -> #(other1 other2 other3) }).
	self assert: historyCtxt allEntries size equals: 3.

]

{ #category : #tests }
TestCtxtHistory >> testPreviousAndNext [
	| focusBefore focusAfter |
	focusBefore := historyCtxt midasFocus.
	historyCtxt midasFocus: (MidasEntityFamixCollection with: { #anAncestor -> #(child1 child2) }).
	focusAfter := historyCtxt midasFocus.
	self deny: focusAfter equals: focusBefore.
	historyCtxt prev.
	self assert: historyCtxt midasFocus equals: focusBefore.
	historyCtxt next.
	self assert: historyCtxt midasFocus equals: focusAfter
]

{ #category : #tests }
TestCtxtHistory >> testSizeBack [
	self assert: historyCtxt history size equals: 1.
	historyCtxt midasFocus: (MidasEntityFamixCollection with: { #anAncestor -> #(child1 child2) }).
	self assert: historyCtxt history size equals: 2.
	historyCtxt prev.
	self assert: historyCtxt history size equals: 2.

]
