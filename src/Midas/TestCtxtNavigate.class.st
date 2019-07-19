Class {
	#name : #TestCtxtNavigate,
	#superclass : #TestMidasCtxt,
	#instVars : [
		'navigateCtxt'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestCtxtNavigate >> setUp [
	super setUp.
	navigateCtxt := launcherCtxt spawn: MidasContextNavigate.
	navigateCtxt app: self mockEmptyApp.
]

{ #category : #tests }
TestCtxtNavigate >> testAttributeProperties [
	launcherCtxt strongFocus: models anyOne allAttributes anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 10
]

{ #category : #tests }
TestCtxtNavigate >> testClassProperties [
	launcherCtxt strongFocus: models anyOne allClasses anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 20
]

{ #category : #tests }
TestCtxtNavigate >> testMethodProperties [
	launcherCtxt strongFocus: models anyOne allMethods anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 22
]

{ #category : #tests }
TestCtxtNavigate >> testModelProperties [
	self
		assert: navigateCtxt navigationProperties size
		equals: 5.
	self assert: (navigateCtxt navigationProperties allSatisfy: [:prop | prop name beginsWith: 'All model'])
]

{ #category : #tests }
TestCtxtNavigate >> testNamespaceProperties [
	launcherCtxt strongFocus: models anyOne allNamespaces anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 14
]
