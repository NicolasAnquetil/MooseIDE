Class {
	#name : #TestMidasEntitiesSingle,
	#superclass : #AbstractTestMidasEntities,
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestMidasEntitiesSingle >> testIsModel [
	self deny: MidasEntityFamix new isModel.
	self assert: MidasEntityMooseModel new isModel.
]

{ #category : #tests }
TestMidasEntitiesSingle >> testNextGenerationYieldCollection [
	| md entity |
	entity := Mock new.
	entity stub children willReturn: #( child1 child2 ).

	md := (MidasEntityFamix with: entity ancestor: #anAncestor)
				nextGenerationSelector: #children.

	self assert: md class equals: MidasEntityFamixCollection.
	self assert: md entities size equals: 2.
	self assert: md entities first equals: #child1.
	self assert: md entities second equals: #child2.
	
	self assert: md entitiesWithAncestors size equals: 1.
	self assert: md entitiesWithAncestors first key equals: entity.

]

{ #category : #tests }
TestMidasEntitiesSingle >> testNextGenerationYieldEmpty [
	| md entity |
	entity := Mock new.
	entity stub children willReturn: #().

	md := (MidasEntityFamix with: entity ancestor: #anAncestor)
				nextGenerationSelector: #children.

	self assert: md class equals: MidasEntityEmpty
]

{ #category : #tests }
TestMidasEntitiesSingle >> testNextGenerationYieldSingle [
	| md entity |
	entity := Mock new.
	entity stub children willReturn: #( child ).

	md := (MidasEntityFamix with: entity ancestor: #anAncestor)
				nextGenerationSelector: #children.

	self assert: md class equals: MidasEntityFamix.
	self assert: md entities size equals: 1.
	self assert: md entities first equals: #child.
	
	self assert: md ancestor equals: entity.
]

{ #category : #tests }
TestMidasEntitiesSingle >> testSameModel [
	| m1 m2 |
	m1 := MooseModel new.
	m2 := MooseModel new.

	self deny: (MidasEntityFamix new sameModel: m1).
	self assert: ((MidasEntityMooseModel with: m1 ancestor: nil) sameModel: m1).
	self deny: ((MidasEntityMooseModel with: m1 ancestor: nil) sameModel: m2).
]

{ #category : #tests }
TestMidasEntitiesSingle >> testSelectEntitiesFromIndexes [
	| md entity |
	entity := Mock new.

	md := (MidasEntityFamix with: entity ancestor: #anAncestor).

	self assert: (md selectEntitiesFromIndexes: #(0)) class equals: MidasEntityEmpty.

	self assert: (md selectEntitiesFromIndexes: #(1)) class equals: MidasEntityFamix.
	self assert: (md selectEntitiesFromIndexes: #(1)) entities equals: { entity }.

	self assert: (md selectEntitiesFromIndexes: #(2)) class equals: MidasEntityEmpty.
]

{ #category : #tests }
TestMidasEntitiesSingle >> testSelectEntitiesFromPaths [
	| md entity |
	entity := Mock new.

	md := (MidasEntityFamix with: entity ancestor: #anAncestor).

	self assert: ( md selectEntitiesFromPaths: #((0)) ) isEmpty.

	self assert: ( md selectEntitiesFromPaths: #((1)) ) entities equals: { entity }.
	self assert: ( md selectEntitiesFromPaths: #((1 1)) ) entities equals: { entity }.
	self assert: ( md selectEntitiesFromPaths: #((1) (1 1)) ) entities equals: { entity }.

]
