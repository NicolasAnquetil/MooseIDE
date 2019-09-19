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
	launcherCtxt midasFocus: (MidasEntityFamix with: self someAttributes anyOne ancestor: #anAncestor).
	self
		assert: navigateCtxt navigationProperties size
		equals: 10

"expected navigatinProperties
FAMIX.StructuralEntity.declaredType
FAMIX.SourcedEntity.comments
FAMIX.SourcedEntity.containerFiles  <-- sometimes missing ?!?!
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
	launcherCtxt midasFocus: (MidasEntityFamix with: self someClasses anyOne ancestor: #anAncestor).
	self
		assert: navigateCtxt navigationProperties size
		equals: 20
]

{ #category : #tests }
TestCtxtNavigate >> testEmptyFocus [
	launcherCtxt midasFocus: (MidasEntityEmpty ancestor: #anAncestor).
	self assert: navigateCtxt navigationProperties isEmpty
]

{ #category : #tests }
TestCtxtNavigate >> testHeterogeneousProperties [
	launcherCtxt midasFocus:
		(MidasEntityFamixCollection with: {
			#ancestor1 -> { self someMethods anyOne } .
			#ancestor2 -> { self someClasses anyOne } }).
	self
		assert: navigateCtxt navigationProperties size
		equals: 9 "properties for FAMIXContainerEntity"
		
 "Expected properties:
FAMIX.NamedEntity.parentPackage
FAMIX.SourcedEntity.declaredSourceLanguage
FAMIX.SourcedEntity.comments
FAMIX.ContainerEntity.types
FAMIX.SourcedEntity.sourceAnchor
FAMIX.ContainerEntity.definedAnnotationTypes
FAMIX.ContainerEntity.functions
FAMIX.SourcedEntity.containerFiles   <-- sometimes missing
FAMIX.NamedEntity.annotationInstances
FAMIX.NamedEntity.receivingInvocations"
]

{ #category : #tests }
TestCtxtNavigate >> testHomogeneousProperties [
	launcherCtxt midasFocus:
		(MidasEntityFamixCollection with: { #anAncestor -> self someMethods }).
	self
		assert: navigateCtxt navigationProperties size
		equals: 22 "same as for a single method: #testMethodProperties"
]

{ #category : #tests }
TestCtxtNavigate >> testMethodProperties [
	launcherCtxt midasFocus: (MidasEntityFamix with: self someMethods anyOne ancestor: #anAncestor).
	self
		assert: navigateCtxt navigationProperties size
		equals: 22
]

{ #category : #tests }
TestCtxtNavigate >> testModelProperties [
	self
		assert: navigateCtxt navigationProperties size
		equals: 43
]

{ #category : #tests }
TestCtxtNavigate >> testNamespaceProperties [
	launcherCtxt midasFocus: (MidasEntityFamix with: self someNamespaces anyOne ancestor: #anAncestor).
	self
		assert: navigateCtxt navigationProperties size
		equals: 14
]

{ #category : #tests }
TestCtxtNavigate >> testNavigateFromClass [
	| clazz props |
	clazz := self someClasses detect: [:c | c name = 'ClassA'].
	navigateCtxt midasFocus: (MidasEntityFamix with: clazz ancestor: #anAncestor).
	props := navigateCtxt navigationPropertiesForClass: FAMIXClass.
	navigateCtxt userSelection: (props detect: [:p | p mooseName endsWith: 'FAMIX.Type.methods]']).

	self
		assert: launcherCtxt midasFocus size
		equals: 1
]

{ #category : #tests }
TestCtxtNavigate >> testSelectAllModelClasses [
	| prop |
	prop := MidasEntityNavigateModel new
			 		selector: #allModelClasses 
					yourself.
	navigateCtxt userSelection: prop.
	self assert: navigateCtxt midasFocus size equals: 2
]

{ #category : #tests }
TestCtxtNavigate >> testSelectAllModelPackages [
	| prop |
	prop := MidasEntityNavigateModel new
			 		selector: #allModelPackages
					yourself.
	navigateCtxt userSelection: prop.
	self assert: navigateCtxt midasFocus size equals: 2
]

{ #category : #tests }
TestCtxtNavigate >> testSelectionOnCollectionFocus [
	| selector |
	selector := Mock new.
	selector stub methodSelector willReturn: #attributes.

	launcherCtxt midasFocus: (MidasEntityFamixCollection with: { #anAncestor -> self someClasses }).
	navigateCtxt userSelection: selector.
	self
		assert: navigateCtxt navigationProperties size
		equals: 10
]
