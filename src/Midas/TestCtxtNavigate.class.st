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
	launcherCtxt strongFocus: self someAttributes anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 11
]

{ #category : #tests }
TestCtxtNavigate >> testClassProperties [
	launcherCtxt strongFocus: self someClasses anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 21
]

{ #category : #tests }
TestCtxtNavigate >> testHeterogeneousProperties [
	launcherCtxt strongFocus: {self someMethods anyOne . self someClasses anyOne}.
	self
		assert: navigateCtxt navigationProperties size
		equals: 10 "properties for FAMIXContainerEntity"
]

{ #category : #tests }
TestCtxtNavigate >> testHomogeneousProperties [
	launcherCtxt strongFocus: self someMethods.
	self
		assert: navigateCtxt navigationProperties size
		equals: 23 "same as for a single method: #testMethodProperties"
]

{ #category : #tests }
TestCtxtNavigate >> testMethodProperties [
	launcherCtxt strongFocus: self someMethods anyOne.
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
	launcherCtxt strongFocus: self someNamespaces anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 15
]

{ #category : #tests }
TestCtxtNavigate >> testSelectionOnCollectionFocus [
	| selector |
	selector := Mock new.
	selector stub methodSelector willReturn: #attributes.

	launcherCtxt strongFocus: self someClasses.
	navigateCtxt selected: selector.
	self
		assert: navigateCtxt navigationProperties size
		equals: 11
]
