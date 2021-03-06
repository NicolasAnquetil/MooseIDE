Class {
	#name : #TestQueryApp,
	#superclass : #AbstractTestMidasApp,
	#instVars : [
		'queryApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestQueryApp >> setUp [
	super setUp.
	queryApp := launcherApp launchQueryApp
]

{ #category : #tests }
TestQueryApp >> testClearAppOnUpdate [
	queryApp fldQuery: 'some query'.
	
	queryApp displayFocus: (self midasEntityFamix: #anEntity).
	self assert: queryApp fldQuery isEmpty
]

{ #category : #tests }
TestQueryApp >> testClearSelection [
	| mockCtxt |
	mockCtxt := Mock new.
	mockCtxt stub navigationProperties willReturn: {
		self mockEntity: #property1 .
		self mockEntity: #property2 }.
	queryApp context: mockCtxt.

	queryApp displayFocus: #whatever.

	queryApp selectPropertyAtIndex: 1.
	self assert: queryApp selectedItems size equals: 1.

	queryApp displayFocus: #whatever.

	self assert: queryApp selectedItems size equals: 0
]

{ #category : #tests }
TestQueryApp >> testMnuSelCol [

	self assert: queryApp context queryIsFilter.

	queryApp mnuSelcolSelect: 2.
	self deny: queryApp context queryIsFilter.

	queryApp mnuSelcolSelect: 1.
	self assert: queryApp context queryIsFilter.
]

{ #category : #tests }
TestQueryApp >> testWindowTitle [
	self
		assert: queryApp window title
		equals: 'Navigate ''Model: First-lanModel'''.
	launcherApp context mooseModel: (MidasEntityMooseModel with: models second).
	self
		assert: queryApp window title
		equals: 'Navigate ''Model: Second-simpleModel'''
]
