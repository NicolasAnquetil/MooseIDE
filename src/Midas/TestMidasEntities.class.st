Class {
	#name : #TestMidasEntities,
	#superclass : #TestCase,
	#category : #'Midas-Tests'
}

{ #category : #'as yet unclassified' }
TestMidasEntities >> setupForCollection [
	| cl1 cl2 mod |

	mod := MooseModel new.
	
	cl1 := FAMIXClass new
				name: 'class 1' ;
				mooseModel: mod ;
				yourself.
	FAMIXMethod new name: 'mth 1.1' ; parentType: cl1.
	FAMIXMethod new name: 'mth 1.2' ; parentType: cl1.
	FAMIXComment new content: 'Comment class 1' ; container: cl1.

	cl2 := FAMIXClass new
				name: 'class 2' ;
				mooseModel: mod ;
				yourself.
	FAMIXMethod new name: 'mth 2.1' ; parentType: cl2.
	FAMIXMethod new name: 'mth 2.2' ; parentType: cl2.
	FAMIXMethod new name: 'mth 2.3' ; parentType: cl2.

	^ mod
]

{ #category : #tests }
TestMidasEntities >> testIsModel [
	self deny: MidasEntityEmpty new isModel.
	self deny: MidasEntityFamixCollection new isModel.
	self deny: MidasEntityFamix new isModel.
	self assert: MidasEntityMooseModel new isModel.
]

{ #category : #tests }
TestMidasEntities >> testNextGenerationCollectionToCollection [
	| mod mdEnt |
	mod := self setupForCollection.

	mdEnt := (MidasEntityFamixCollection with: { #someAncestor -> { mod entityNamed: 'class 1' . mod entityNamed: 'class 2' } })
					nextGenerationSelector: #methods.

	self assert: mdEnt class equals: MidasEntityFamixCollection.
	self assert: mdEnt entities size equals: 5.
	self assert: mdEnt entities first name equals: 'mth 1.1'.
	self assert: mdEnt entities last  name equals: 'mth 2.3'.

	self assert: mdEnt entitiesWithAncestors size equals: 2.
	self assert: mdEnt entitiesWithAncestors first  key name equals: 'class 1'.
	self assert: mdEnt entitiesWithAncestors first  value size equals: 2.
	self assert: mdEnt entitiesWithAncestors second key name equals: 'class 2'.
	self assert: mdEnt entitiesWithAncestors second value size equals: 3.
]

{ #category : #tests }
TestMidasEntities >> testNextGenerationCollectionToEmpty [
	| mod mdEnt |
	mod := self setupForCollection.

	mdEnt := (MidasEntityFamixCollection with: { #someAncestor -> mod allClasses })
					nextGenerationSelector: #attributes.

	self assert: mdEnt class equals: MidasEntityEmpty.
	self assert: mdEnt ancestor size equals: 2.
]

{ #category : #tests }
TestMidasEntities >> testNextGenerationCollectionToSingle [
	| mod mdEnt |
	mod := self setupForCollection.

	mdEnt := (MidasEntityFamixCollection with: { #someAncestor -> mod allClasses })
					nextGenerationSelector: #comments.

	self assert: mdEnt class equals: MidasEntityFamix.
	self assert: mdEnt entities size equals: 1.
	self assert: mdEnt entities first class equals: FAMIXComment.
	self assert: mdEnt entities first content equals: 'Comment class 1'.

	self assert: mdEnt ancestor class equals: FAMIXClass.
	self assert: mdEnt ancestor name equals: 'class 1'.
]

{ #category : #tests }
TestMidasEntities >> testNextGenerationEmpty [
	| md |
	md := (MidasEntityEmpty ancestor: nil)
				nextGenerationSelector: #whatever.

	self assert: md class equals: MidasEntityEmpty
]

{ #category : #tests }
TestMidasEntities >> testNextGenerationSingleToCollection [
	| cl mth1 mth2 md |
	"Creates a MidasEntityFamix with a class that has some methods"
	cl := FAMIXClass new.
	mth1 := FAMIXMethod new.
	mth1 parentType: cl.
	mth2 := FAMIXMethod new.
	mth2 parentType: cl.

	md := (MidasEntityFamix with: cl ancestor: nil)
				nextGenerationSelector: #methods.

	self assert: md class equals: MidasEntityFamixCollection.
	self assert: md entities size equals: 2.
	self assert: md entities first equals: mth1.
	self assert: md entities second equals: mth2.
	
	self assert: md entitiesWithAncestors size equals: 1.
	self assert: md entitiesWithAncestors first key equals: cl.

]

{ #category : #tests }
TestMidasEntities >> testNextGenerationSingleToEmpty [
	| cl md |
	"Creates a MidasEntityFamix with a class that has no method"
	cl := FAMIXClass new.
	md := (MidasEntityFamix with: cl ancestor: nil)
				nextGenerationSelector: #methods.

	self assert: md class equals: MidasEntityEmpty.
	self assert: md ancestor equals: cl.
]

{ #category : #tests }
TestMidasEntities >> testNextGenerationSingleToSingle [
	| cl mth md |
	"Creates a MidasEntityFamix with a class that has one method"
	cl := FAMIXClass new.
	mth := FAMIXMethod new.
	mth parentType: cl.

	md := (MidasEntityFamix with: cl ancestor: nil)
				nextGenerationSelector: #methods.

	self assert: md class equals: MidasEntityFamix.
	self assert: md entities size equals: 1.
	self assert: md entities first equals: mth.
	
	self assert: md ancestor equals: cl.
]

{ #category : #tests }
TestMidasEntities >> testSameModel [
	| m1 m2 |
	m1 := MooseModel new.
	m2 := MooseModel new.

	self deny: (MidasEntityEmpty new sameModel: m1).
	self deny: (MidasEntityFamixCollection new sameModel: m1).
	self deny: (MidasEntityFamix new sameModel: m1).
	self assert: ((MidasEntityMooseModel with: m1 ancestor: nil) sameModel: m1).
	self deny: ((MidasEntityMooseModel with: m1 ancestor: nil) sameModel: m2).
]
