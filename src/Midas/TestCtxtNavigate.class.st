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
		equals: 11
]

{ #category : #tests }
TestCtxtNavigate >> testClassProperties [
	launcherCtxt strongFocus: models anyOne allClasses anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 21
]

{ #category : #tests }
TestCtxtNavigate >> testHeterogeneousProperties [
	launcherCtxt strongFocus: {models anyOne allModelMethods anyOne . models anyOne allModelClasses anyOne}.
	self
		assert: navigateCtxt navigationProperties size
		equals: 10 "properties for FAMIXContainerEntity"
]

{ #category : #tests }
TestCtxtNavigate >> testHomogeneousProperties [
	launcherCtxt strongFocus: models anyOne allModelMethods.
	self
		assert: navigateCtxt navigationProperties size
		equals: 23 "same as for a single method: #testMethodProperties"
]

{ #category : #tests }
TestCtxtNavigate >> testMethodProperties [
	launcherCtxt strongFocus: models anyOne allMethods anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 23
]

{ #category : #tests }
TestCtxtNavigate >> testModelProperties [
	self
		assert: navigateCtxt navigationProperties size
		equals: 41
]

{ #category : #tests }
TestCtxtNavigate >> testNamespaceProperties [
	launcherCtxt strongFocus: models anyOne allNamespaces anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 15
]
