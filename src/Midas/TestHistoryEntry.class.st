Class {
	#name : #TestHistoryEntry,
	#superclass : #AbstractTestMidas,
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestHistoryEntry >> testDescription [
	| entry |
	entry := MidasHistoryEntry
					with: (self midasEntityCollection:
								 { #ancestor1 -> #child11 . 
									#ancestor1 -> #child12 .
									#ancestor2 -> #child21} ).
	self
		assert: entry summaryDescription
		equals: 'child11
child12
child21'
]

{ #category : #tests }
TestHistoryEntry >> testDescriptionMooseModel [
	| model |
	model := (MidasHistoryEntry with: (self midasEntityModel: 'test model')).
	self
		assert:  model summaryDescription
		equals: 'MooseModel:test model'
]

{ #category : #tests }
TestHistoryEntry >> testDescriptionSingleEntity [
	self
		assert: (MidasHistoryEntry with: (self midasEntityFamix: 'just me'))
						 summaryDescription
		equals: 'just me'
]

{ #category : #tests }
TestHistoryEntry >> testLongDescription [
	| entry |
	entry := MidasHistoryEntry
					with: (self midasEntityCollection:
								 { #ancestor1 -> 'some long text' .
									#ancestor1 -> 'even longer text' .
									#ancestor1 -> 'and even longer yet' .
									#ancestor1 -> 'the goal is to sum up more than 100 characters' .
									#ancestor1 -> 'all this to force elipsis in the summary description' }).
	self assert: entry summaryDescription equals: 'some long text
even longer text
and even longer yet
the goal is to sum up more than 100 characters
...'
]

{ #category : #tests }
TestHistoryEntry >> testNamed [
	| entry |
	entry := MidasHistoryEntry with: (self midasEntityFamix: 'blah').
	self
		assert: entry entryName
		equals: ''.
	entry entryName: 'entryBlah'.
	self
		assert: entry entryName
		equals: 'entryBlah'.

]

{ #category : #tests }
TestHistoryEntry >> testRemoveCurrentLeaf [
	| history |
	history := MidasHistory new.
	history addEntry: #root.
	history addEntry: #leaf.
	self assert: history currentEntry value equals: #leaf.
	self assert: history allEntries size equals: 2.
	
	history removeEntry: history currentEntry.
	self assert: history currentEntry value equals: #root.
	self assert: history allEntries size equals: 1.

]

{ #category : #tests }
TestHistoryEntry >> testRemoveCurrentRoot [
	| history root |
	history := MidasHistory new.
	history addEntry: #root.
	root := history currentEntry.
	history addEntry: #leaf.

	self assert: history currentEntry value equals: #leaf.
	self assert: history allEntries size equals: 2.
	
	history removeEntry: root.
	self assert: history currentEntry value equals: #root.
	self assert: history allEntries size equals: 1.

]

{ #category : #tests }
TestHistoryEntry >> testRemoveCurrentSibling [
	| history root |
	history := MidasHistory new.
	history addEntry: #root.
	root := history currentEntry.
	history addEntry: #leaf1.
	history currentEntry: root.
	history addEntry: #leaf2.

	self assert: history currentEntry value equals: #leaf2.
	self assert: history allEntries size equals: 3.
	
	history removeEntry: history currentEntry.
	self assert: history currentEntry value equals: #root.
	self assert: history allEntries size equals: 2.

]
