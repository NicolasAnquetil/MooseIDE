Class {
	#name : #StubMethodTest,
	#superclass : #TestCase,
	#instVars : [
		'method'
	],
	#category : #'Midas-test'
}

{ #category : #data }
StubMethodTest >> dataCyclo1 [
	self flag: 'data for test'
]

{ #category : #data }
StubMethodTest >> dataCyclo3 [
	self flag: 'data for test'.
	(1 = 3)
		ifTrue: [ self signal: Error ]
		ifFalse: [ 1 isNumber ifTrue: [ ^ 'good' ] ]
]

{ #category : #tests }
StubMethodTest >> testChildren [
	|meth|
	meth := StubMethod new entity: StubMethodTest >> #testChildren.
	self assert: meth children size equals: 1
]

{ #category : #tests }
StubMethodTest >> testCyclomaticComplexity [
	self
		assert: (StubMethod new entity: StubMethodTest>>#dataCyclo1) cyclomaticComplexity
		equals: 1.
	self
		assert: (StubMethod new entity: StubMethodTest>>#dataCyclo3) cyclomaticComplexity
		equals: 3
]

{ #category : #tests }
StubMethodTest >> testNumberOfLinesOfCode [
	|meth|
	meth := StubMethod new entity: StubMethodTest >> #testNumberOfLinesOfCode.
	self assert: meth numberOfLinesOfCode equals: 4
]
