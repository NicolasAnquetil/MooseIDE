Class {
	#name : #TestCtxtQuery,
	#superclass : #AbstractTestMidasCtxt,
	#instVars : [
		'queryCtxt'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestCtxtQuery >> setUp [
	super setUp.
	queryCtxt := launcherCtxt spawn: MidasContextQuery.
	queryCtxt app: self mockEmptyApp.
]

{ #category : #tests }
TestCtxtQuery >> testEmptyFocus [
	launcherCtxt midasFocus: (MidasEntityEmpty ancestor: #anAncestor).
	self assert: queryCtxt navigationProperties isEmpty
]

{ #category : #tests }
TestCtxtQuery >> testInitialFocus [
	
	self assert: queryCtxt midasFocus isModel 
]

{ #category : #tests }
TestCtxtQuery >> testNavigateFromClass [
	| clazz props |
	clazz := self someClasses detect: [:c | c name = 'ClassA'].
	queryCtxt midasFocus: (MidasEntityFamix with: clazz ancestor: #anAncestor).
	props := queryCtxt navigationPropertiesForClass: FAMIXClass.
	queryCtxt userSelection: (props detect: [:p | p mooseName endsWith: 'FAMIX.Type.methods]']).

	self
		assert: launcherCtxt midasFocus size
		equals: 1
]

{ #category : #tests }
TestCtxtQuery >> testPropertiesAttribute [
	launcherCtxt midasFocus: (MidasEntityFamix with: self someAttributes anyOne ancestor: #anAncestor).
	self
		assert: queryCtxt navigationProperties size
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
TestCtxtQuery >> testPropertiesClass [
	launcherCtxt midasFocus: (MidasEntityFamix with: self someClasses anyOne ancestor: #anAncestor).
	self
		assert: queryCtxt navigationProperties size
		equals: 20
]

{ #category : #tests }
TestCtxtQuery >> testPropertiesHeterogeneous [
	launcherCtxt midasFocus:
		(MidasEntityFamixCollection with: {
			#ancestor1 -> { self someMethods anyOne } .
			#ancestor2 -> { self someClasses anyOne } }).
	self
		assert: queryCtxt navigationProperties size
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
TestCtxtQuery >> testPropertiesHomogeneous [
	launcherCtxt midasFocus:
		(MidasEntityFamixCollection with: { #anAncestor -> self someMethods }).
	self
		assert: queryCtxt navigationProperties size
		equals: 22 "same as for a single method: #testMethodProperties"
]

{ #category : #tests }
TestCtxtQuery >> testPropertiesMethod [
	launcherCtxt midasFocus: (MidasEntityFamix with: self someMethods anyOne ancestor: #anAncestor).
	self
		assert: queryCtxt navigationProperties size
		equals: 22
]

{ #category : #tests }
TestCtxtQuery >> testPropertiesModel [
	self
		assert: queryCtxt navigationProperties size
		equals: 43
]

{ #category : #tests }
TestCtxtQuery >> testPropertiesNamespace [
	launcherCtxt midasFocus: (MidasEntityFamix with: self someNamespaces anyOne ancestor: #anAncestor).
	self
		assert: queryCtxt navigationProperties size
		equals: 14
]

{ #category : #tests }
TestCtxtQuery >> testSelectAllModelClasses [
	| prop |
	prop := MidasEntityNavigateModel new
			 		selector: #allModelClasses 
					yourself.
	queryCtxt userSelection: prop.
	self assert: queryCtxt midasFocus size equals: 2
]

{ #category : #tests }
TestCtxtQuery >> testSelectAllModelPackages [
	| prop |
	prop := MidasEntityNavigateModel new
			 		selector: #allModelPackages
					yourself.
	queryCtxt userSelection: prop.
	self assert: queryCtxt midasFocus size equals: 2
]

{ #category : #tests }
TestCtxtQuery >> testSelectionOnCollectionFocus [
	| selector |
	selector := Mock new.
	selector stub methodSelector willReturn: #attributes.

	launcherCtxt midasFocus: (MidasEntityFamixCollection with: { #anAncestor -> self someClasses }).
	queryCtxt userSelection: selector.
	self
		assert: queryCtxt navigationProperties size
		equals: 10
]
