Class {
	#name : #TestNavigateApp,
	#superclass : #TestMidasApp,
	#instVars : [
		'navigateApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestNavigateApp >> setUp [
	super setUp.
	navigateApp := launcherApp launchNavigateApp
]

{ #category : #tests }
TestNavigateApp >> testClearSelection [
	| mockCtxt |
	mockCtxt := Mock new.
	mockCtxt stub navigationProperties willReturn: {
		self mockEntity: #property1 .
		self mockEntity: #property2 }.
	navigateApp context: mockCtxt.

	navigateApp updateMidasFocus: #whatever.

	navigateApp lstProperties clickAtIndex: 1.
	self assert: navigateApp selectedItems size equals: 1.

	navigateApp updateMidasFocus: #whatever.

	self assert: navigateApp selectedItems size equals: 0
]

{ #category : #tests }
TestNavigateApp >> testWindowTitle [
	self
		assert: navigateApp window title
		equals: 'Navigate ''Model: First-lanModel'''.
	launcherApp context mooseModel: (MidasEntityMooseModel with: models second).
	self
		assert: navigateApp window title
		equals: 'Navigate ''Model: Second-simpleModel'''
]
