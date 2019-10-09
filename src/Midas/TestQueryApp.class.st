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
TestQueryApp >> testClearSelection [
	| mockCtxt |
	mockCtxt := Mock new.
	mockCtxt stub navigationProperties willReturn: {
		self mockEntity: #property1 .
		self mockEntity: #property2 }.
	queryApp context: mockCtxt.

	queryApp updateMidasFocus: #whatever.

	queryApp lstProperties clickAtIndex: 1.
	self assert: queryApp selectedItems size equals: 1.

	queryApp updateMidasFocus: #whatever.

	self assert: queryApp selectedItems size equals: 0
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
