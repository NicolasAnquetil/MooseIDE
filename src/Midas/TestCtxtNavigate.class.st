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
	launcherCtxt midasFocus: self someAttributes anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 11

"expected navigatinProperties
FAMIX.StructuralEntity.declaredType
FAMIX.SourcedEntity.comments
FAMIX.SourcedEntity.containerFiles
FAMIX.NamedEntity.annotationInstances
FAMIX.StructuralEntity.incomingAccesses
FAMIX.SourcedEntity.declaredSourceLanguage
FAMIX.Attribute.parentType
FAMIX.NamedEntity.parentPackage
FAMIX.StructuralEntity.dereferencedInvocations
FAMIX.SourcedEntity.sourceAnchor
FAMIX.NamedEntity.receivingInvocations"	
]

{ #category : #tests }
TestCtxtNavigate >> testClassProperties [
	launcherCtxt midasFocus: self someClasses anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 21
]

{ #category : #tests }
TestCtxtNavigate >> testHeterogeneousProperties [
	launcherCtxt midasFocus: {self someMethods anyOne . self someClasses anyOne}.
	self
		assert: navigateCtxt navigationProperties size
		equals: 10 "properties for FAMIXContainerEntity"
		
 "Expected properties:
FAMIX.NamedEntity.parentPackage
FAMIX.SourcedEntity.declaredSourceLanguage
FAMIX.SourcedEntity.comments
FAMIX.ContainerEntity.types
FAMIX.SourcedEntity.sourceAnchor
FAMIX.ContainerEntity.definedAnnotationTypes
FAMIX.ContainerEntity.functions
FAMIX.SourcedEntity.containerFiles
FAMIX.NamedEntity.annotationInstances
FAMIX.NamedEntity.receivingInvocations"
]

{ #category : #tests }
TestCtxtNavigate >> testHomogeneousProperties [
	launcherCtxt midasFocus: self someMethods.
	self
		assert: navigateCtxt navigationProperties size
		equals: 23 "same as for a single method: #testMethodProperties"
]

{ #category : #tests }
TestCtxtNavigate >> testMethodProperties [
	launcherCtxt midasFocus: self someMethods anyOne.
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
	launcherCtxt midasFocus: self someNamespaces anyOne.
	self
		assert: navigateCtxt navigationProperties size
		equals: 15
]

{ #category : #tests }
TestCtxtNavigate >> testSelectionOnCollectionFocus [
	| selector |
	selector := Mock new.
	selector stub methodSelector willReturn: #attributes.

	launcherCtxt midasFocus: self someClasses.
	navigateCtxt selected: selector.
	self
		assert: navigateCtxt navigationProperties size
		equals: 11
]
