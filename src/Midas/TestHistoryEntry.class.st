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
	entry := HistoryEntry with: {  self entity: 'first' . self entity: 'second' . self entity: 'third' }.
	self assert: entry summaryDescription equals: 'first
second
third'
]

{ #category : #tests }
TestHistoryEntry >> testDescriptionSingleEntity [
	| entry |
	entry := HistoryEntry with: (self entity: 'just me').
	self assert: entry summaryDescription equals: 'just me'
]

{ #category : #tests }
TestHistoryEntry >> testLongDescription [
	| entry |
	entry := HistoryEntry with: {
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
