Class {
	#name : #TestSystemComplexityApp,
	#superclass : #AbstractTestMidasApp,
	#instVars : [
		'systCompApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestSystemComplexityApp >> colorForRoassalElement: anInteger [ 
	^ (systCompApp roassalView elements at: anInteger) trachelShape strokePaint
]

{ #category : #running }
TestSystemComplexityApp >> setUp [
	super setUp.
	systCompApp := launcherApp launchSystemComplexityApp
]

{ #category : #tests }
TestSystemComplexityApp >> testHighlightFocus [
	| mockCtxt |
	mockCtxt := Mock new.
	systCompApp context: mockCtxt.

	mockCtxt stub roots willReturn: #( entity1 entity2 entity3 ).
	systCompApp highlight: #( entity2 entity3 ).

	self assert: (self colorForRoassalElement: 1) equals: Color black.
	self assert: (self colorForRoassalElement: 2) equals: Color red.
	self assert: (self colorForRoassalElement: 3) equals: Color red.

]

{ #category : #tests }
TestSystemComplexityApp >> testNbElementsFlat [
	| mockCtxt |
	mockCtxt := Mock new.
	systCompApp context: mockCtxt.

	mockCtxt stub roots willReturn: #( entity ).
	systCompApp updateMidasFocus: #whatever.
	self assert: systCompApp roassalView elements size equals: 1.
	
	mockCtxt stub roots willReturn: #( entity1 entity2 entity3 ).
	systCompApp updateMidasFocus: #whatever.
	self assert: systCompApp roassalView elements size equals: 3
]

{ #category : #tests }
TestSystemComplexityApp >> testNbElementsHierarchical [
	| mockCtxt |
	mockCtxt := Mock new.
	systCompApp context: mockCtxt.

	mockCtxt stub roots willReturn: #( entity1 entity2 ).
	(mockCtxt stub childrenFor: Any) willReturn: #( child1 child2 ).
	systCompApp updateMidasFocus: #whatever.
	self assert: systCompApp roassalView elements size equals: 6
]

{ #category : #tests }
TestSystemComplexityApp >> testUpdateFocus [
	self assert: systCompApp roassalView elements size equals: 1
]
