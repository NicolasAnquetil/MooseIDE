Class {
	#name : #TestHistoryEntry,
	#superclass : #TestMidas,
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestHistoryEntry >> testDescription [
	| entry |
	entry := MidasHistoryEntry
					with: (self midasEntityCollection:
								 { #ancestor1 -> 'first' . 
									#ancestor1 -> 'second' .
									#ancestor2 -> 'third'} ).
	self
		assert: entry summaryDescription
		equals: 'first
second
third'
]

{ #category : #tests }
TestHistoryEntry >> testDescriptionMooseModel [
	| model |
	model := (MidasHistoryEntry with: (self midasEntityModel: 'test model')).
	self
		assert:  model summaryDescription
		equals: 'test model'
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
								 { #ancestor1 -> { self mockEntity: 'some long text' .
														self mockEntity: 'even longer text' .
														self mockEntity: 'and even longer yet' .
														self mockEntity: 'the goal is to sum up more than 100 characters' .
														self mockEntity: 'all this to force elipsis in the summary description' }}).
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
