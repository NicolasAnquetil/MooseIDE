Class {
	#name : #TestMidasEntitiesCollection,
	#superclass : #AbstractTestMidasEntities,
	#instVars : [
		'md',
		'entity1',
		'entity2'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestMidasEntitiesCollection >> setUp [
	entity1 := Mock new.
	entity2 := Mock new.

	md := (MidasEntityFamixCollection with: { #ancestor -> { entity1 . entity2 } } ).

]

{ #category : #tests }
TestMidasEntitiesCollection >> testIsModel [
	self deny: md isModel.
]

{ #category : #tests }
TestMidasEntitiesCollection >> testNextGenerationYieldCollection [
	entity1 stub children willReturn: #( child11 child12 ).
	entity2 stub children willReturn: #( child21 child22 child23 ).

	md := md nextGenerationSelector: #children.

	self assert: md class equals: MidasEntityFamixCollection.
	self assert: md entities size equals: 5.
	self assert: md entities first equals: #child11.
	self assert: md entities last  equals: #child23.

	self assert: md entitiesWithAncestors size equals: 2.
	self assert: md entitiesWithAncestors first  key equals: entity1.
	self assert: md entitiesWithAncestors first  value size equals: 2.
	self assert: md entitiesWithAncestors second key equals: entity2.
	self assert: md entitiesWithAncestors second value size equals: 3.
]

{ #category : #tests }
TestMidasEntitiesCollection >> testNextGenerationYieldEmpty [
	entity1 stub children willReturn: #().
	entity2 stub children willReturn: #().

	md := md nextGenerationSelector: #children.

	self assert: md class equals: MidasEntityEmpty.
	self assert: md ancestor equals: { entity1 . entity2 }
]

{ #category : #tests }
TestMidasEntitiesCollection >> testNextGenerationYieldSingle [
	entity1 stub children willReturn: #( child ).
	entity2 stub children willReturn: #().

	md := md nextGenerationSelector: #children.

	self assert: md class equals: MidasEntityFamix.
	self assert: md entities size equals: 1.
	self assert: md entities first equals: #child.

	self assert: md ancestor equals: entity1.
]

{ #category : #tests }
TestMidasEntitiesCollection >> testPathsForFound [
	| search |
	md := MidasEntityFamixCollection
				with: {
					#entity1 -> #( child11 child12 ) .
					#entity2 -> #( child21 child22 child23 ) }.

	search := MidasEntityFamixCollection
				with: {
					#entity1 -> #( child11 ) .
					#entity2 -> #( child22 ) }.
	self
		assert: (md pathsFor: search )
		equals: #( (1 1) (2 2) ) asOrderedCollection
]

{ #category : #tests }
TestMidasEntitiesCollection >> testPathsForNotFound [
	| search |
	md := MidasEntityFamixCollection
				with: {
					#entity1 -> #( child11 child12 ) .
					#entity2 -> #( child21 child22 child23 ) }.

	search := MidasEntityFamixCollection
				with: {
					#entity3 -> #( child31 ) .
					#entity2 -> #( child25 ) }.
	self
		assert: (md pathsFor: search )
		equals: #( ) asOrderedCollection
]

{ #category : #tests }
TestMidasEntitiesCollection >> testSameModel [
	self deny: (md sameModel: #whatever)
]

{ #category : #tests }
TestMidasEntitiesCollection >> testSelectEntitiesFromIndexes [
	md := MidasEntityFamixCollection
				with: {
					entity1 -> #( child11 child12 ) .
					entity2 -> #( child21 child22 child23 ) }.

	self assert: (md selectEntitiesFromIndexes: #(0)) class equals: MidasEntityEmpty.

	self assert: (md selectEntitiesFromIndexes: #(1)) class equals: MidasEntityFamix.
	self assert: (md selectEntitiesFromIndexes: #(1)) entities equals: #( child11 ).

	self assert: (md selectEntitiesFromIndexes: #(4)) class equals: MidasEntityFamix.
	self assert: (md selectEntitiesFromIndexes: #(4)) entities equals: #( child22 ).

	self assert: (md selectEntitiesFromIndexes: #(2 5)) class equals: MidasEntityFamixCollection.
	self assert: (md selectEntitiesFromIndexes: #(2 5)) entitiesWithAncestors size equals: 2.
	self assert: (md selectEntitiesFromIndexes: #(2 5)) entities equals: #( #child12 child23 ).

]

{ #category : #tests }
TestMidasEntitiesCollection >> testSelectEntitiesFromPaths [
	md := MidasEntityFamixCollection
				with: {
					entity1 -> #( child11 child12 ) .
					entity2 -> #( child21 child22 child23 ) }.

	self assert: (md selectEntitiesFromPaths: #( (1 1) )) entities equals: #( child11 ).

	self assert: (md selectEntitiesFromPaths: #( (2 2) )) entities equals: #( child22 ).

	self assert: (md selectEntitiesFromPaths: #( (1 2) (2 3) )) entitiesWithAncestors size equals: 2.
	self assert: (md selectEntitiesFromPaths: #( (1 2) (2 3) )) entities
			equals: #( #child12 child23 ) asOrderedCollection.

	self assert: (md selectEntitiesFromPaths: #( (1) )) entitiesWithAncestors size equals: 1.
	self assert: (md selectEntitiesFromPaths: #( (1) )) entities
			equals: #( child11 child12 ) asOrderedCollection.

	self assert: (md selectEntitiesFromPaths: #( (1) (2 3) )) entitiesWithAncestors size equals: 2.
	self assert: (md selectEntitiesFromPaths: #( (1) (2 3) )) entities
			equals: #( child11 child12 child23 ) asOrderedCollection.

]
