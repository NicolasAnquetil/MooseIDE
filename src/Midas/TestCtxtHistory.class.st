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
TestCtxtHistory >> testBack [
	self assert: historyCtxt history size equals: 1.
	historyCtxt midasFocus: self someClasses.
	self assert: historyCtxt history size equals: 2.
	historyCtxt prev.
	self assert: historyCtxt history size equals: 2.

]

{ #category : #tests }
TestCtxtHistory >> testEntriesBranchingCount [
	self assert: historyCtxt allEntries size equals: 1.
	self assert: historyCtxt history firstEntry nextEntries size equals: 0.
	historyCtxt midasFocus: self someClasses.
	self assert: historyCtxt allEntries size equals: 2.
	self assert: historyCtxt history firstEntry nextEntries size equals: 1.
	historyCtxt prev.
	historyCtxt midasFocus: self somePackages.
	self assert: historyCtxt allEntries size equals: 3.
	self assert: historyCtxt history firstEntry nextEntries size equals: 2.

]

{ #category : #tests }
TestCtxtHistory >> testEntriesCount [
	self assert: historyCtxt allEntries size equals: 1.
	historyCtxt midasFocus: self someClasses.
	self assert: historyCtxt allEntries size equals: 2.
	historyCtxt midasFocus: self somePackages.
	self assert: historyCtxt allEntries size equals: 3.

]

{ #category : #tests }
TestCtxtHistory >> testPreviousAndNext [
	| focusBefore focusAfter |
	focusBefore := historyCtxt midasFocus.
	historyCtxt midasFocus: self someClasses.
	focusAfter := historyCtxt midasFocus.
	self deny: focusAfter equals: focusBefore.
	historyCtxt prev.
	self assert: historyCtxt midasFocus equals: focusBefore.
	historyCtxt next.
	self assert: historyCtxt midasFocus equals: focusAfter
]
