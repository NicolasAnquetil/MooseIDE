Class {
	#name : #StubModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'MooseIDE-test'
}

{ #category : #running }
StubModelTest >> setUp [
	super setUp.
	model := StubModel new
]

{ #category : #tests }
StubModelTest >> testAllEntityTypes [

	self assert: model allEntityTypes size equals: 1.
	self assert: model allEntityTypes anyOne name equals: 'StubModel'.

	model entities.
	self assert: model allEntityTypes size equals: 6
]

{ #category : #tests }
StubModelTest >> testAllWithType [
1halt.
	self assert: (model allWithType: StubModel) size equals: 1.
	self assert: (model allWithType: StubModel) anyOne name equals: 'MooseIDE model'.

	model entities.
	self assert: (model allWithType: StubPackage) size equals: 1.
	self assert: (model allWithType: StubPackage) anyOne name equals: 'MooseIDE'.


]

{ #category : #tests }
StubModelTest >> testCyclomaticComplexity [
	self assert: ((1 to: 1.1) rangeIncludes: model cyclomaticComplexity)
]

{ #category : #tests }
StubModelTest >> testNumberOfClasses [
	self assert: model numberOfClasses equals: 17
]
