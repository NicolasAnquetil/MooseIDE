Class {
	#name : #TestHistoryEntry,
	#superclass : #TestCase,
	#category : #'Midas-Tests'
}

{ #category : #accessing }
TestHistoryEntry >> entity: anObject [
	| mockEntity |
	mockEntity := Mock new.
	mockEntity stub name willReturn: (anObject asString).
	^mockEntity
	
]

{ #category : #tests }
TestHistoryEntry >> testDescription [
	| entry |
	entry := MidasHistoryEntry with: {  self entity: 'first' . self entity: 'second' . self entity: 'third' }.
	self
		assert: entry summaryDescription
		equals: 'first
second
third'
]

{ #category : #tests }
TestHistoryEntry >> testDescriptionMooseModel [
	| model |
	model := MooseModel new
					name: 'test model' ;
					yourself.
	self
		assert: (HistoryMooseModelEntry with: model) summaryDescription
		equals: 'test model'
]

{ #category : #tests }
TestHistoryEntry >> testDescriptionSingleEntity [
	self
		assert: (MidasHistoryEntry with: (self entity: 'just me')) summaryDescription
		equals: 'just me'
]

{ #category : #tests }
TestHistoryEntry >> testLongDescription [
	| entry |
	entry := MidasHistoryEntry with: {
		self entity: 'some long text' .
		self entity: 'even longer text' .
		self entity: 'and even longer yet' .
		self entity: 'the goal is to sum up more than 100 characters' .
		self entity: 'all this to force elipsis in the summary description' }.
	self assert: entry summaryDescription equals: 'some long text
even longer text
and even longer yet
the goal is to sum up more than 100 characters
...'
]

{ #category : #tests }
TestHistoryEntry >> testNamed [
	| entry |
	entry := MidasHistoryEntry with: (self entity: 'blah').
	self
		assert: entry entryName
		equals: ''.
	entry entryName: 'entryBlah'.
	self
		assert: entry entryName
		equals: 'entryBlah'.

]
