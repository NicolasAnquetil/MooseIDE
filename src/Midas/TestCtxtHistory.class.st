Class {
	#name : #TestCtxtHistory,
	#superclass : #AbstractTestMidasCtxt,
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
	historyCtxt midasFocus: (MidasEntityCollection with: { #anAncestor -> #(child1 child2) }).
	self assert: historyCtxt allEntries size equals: 2.
	self assert: historyCtxt history firstEntry nextEntries size equals: 1.
	historyCtxt prev.
	historyCtxt midasFocus: (MidasEntityCollection with: { #anAncestor -> #(other1 other2 other3) }).
	self assert: historyCtxt allEntries size equals: 3.
	self assert: historyCtxt history firstEntry nextEntries size equals: 2.

]

{ #category : #tests }
TestCtxtHistory >> testEntriesCount [
	self assert: historyCtxt allEntries size equals: 1.
	historyCtxt midasFocus: (MidasEntityCollection with: { #anAncestor -> #(child1 child2) }).
	self assert: historyCtxt allEntries size equals: 2.
	historyCtxt midasFocus: (MidasEntityCollection with: { #anAncestor -> #(other1 other2 other3) }).
	self assert: historyCtxt allEntries size equals: 3.

]

{ #category : #tests }
TestCtxtHistory >> testForgetHistoryBranch [
	| branch |
	self assert: historyCtxt allEntries size equals: 1.
	self assert: historyCtxt current value isModel.

	historyCtxt midasFocus: (self midasEntityFamix: #child1 ).
	self assert: historyCtxt allEntries size equals: 2.
	branch := historyCtxt current.
	self assert: branch value singleEntity mockName equals: 'child1'.

	historyCtxt midasFocus: (self midasEntityFamix: #child2 ).
	self assert: historyCtxt allEntries size equals: 3.
	self assert: historyCtxt current value singleEntity mockName equals: 'child2'.

	historyCtxt forgetHistoryAfter: branch.
	self assert: historyCtxt allEntries size equals: 1.
	self assert: historyCtxt current value isModel.

]

{ #category : #tests }
TestCtxtHistory >> testForgetHistoryLeaf [
	self assert: historyCtxt allEntries size equals: 1.
	self assert: historyCtxt current value isModel.

	historyCtxt midasFocus: (self midasEntityFamix: #child ).
	self assert: historyCtxt allEntries size equals: 2.
	self assert: historyCtxt current value singleEntity mockName equals: 'child'.

	historyCtxt forgetHistoryAfter: historyCtxt current.
	self assert: historyCtxt allEntries size equals: 1.
	self assert: historyCtxt current value isModel.

]

{ #category : #tests }
TestCtxtHistory >> testForgetHistoryRoot [
	| root |
	root := historyCtxt current.
	self assert: historyCtxt allEntries size equals: 1.
	self assert: historyCtxt current value isModel.

	historyCtxt midasFocus: (self midasEntityFamix: #child1 ).
	self assert: historyCtxt allEntries size equals: 2.
	self assert: historyCtxt current value singleEntity mockName equals: 'child1'.

	historyCtxt midasFocus: (self midasEntityFamix: #child2 ).
	self assert: historyCtxt allEntries size equals: 3.
	self assert: historyCtxt current value singleEntity  mockName equals: 'child2'.

	historyCtxt forgetHistoryAfter: root.
	self assert: historyCtxt allEntries size equals: 1.
	self assert: historyCtxt current value ancestor isNil.

]

{ #category : #tests }
TestCtxtHistory >> testPreviousAndNext [
	| focusBefore focusAfter |
	focusBefore := historyCtxt midasFocus.
	historyCtxt midasFocus: (MidasEntityCollection with: { #anAncestor -> #(child1 child2) }).
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
	historyCtxt midasFocus: (MidasEntityCollection with: { #anAncestor -> #(child1 child2) }).
	self assert: historyCtxt history size equals: 2.
	historyCtxt prev.
	self assert: historyCtxt history size equals: 2.

]
