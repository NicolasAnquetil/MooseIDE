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
	entity1 := self mockEntity: 'entity1'.
	entity2 := self mockEntity: 'entity2'.

	md := MidasEntityCollection with: { #ancestor -> { entity1 . entity2 } } .

]

{ #category : #tests }
TestMidasEntitiesCollection >> testIsModel [
	self deny: md isModel.
]

{ #category : #tests }
TestMidasEntitiesCollection >> testNextGenerationYieldCollection [
	entity1 stub children willReturn: { self mockEntity: 'child11' . self mockEntity: 'child12' }.
	entity2 stub children willReturn: { self mockEntity: 'child21' . self mockEntity: 'child22' . self mockEntity: 'child23' }.
	md := md 	nextGenerationFromProperty:
					(MidasFM3PropertyForModels new
			 			selector: #children 
						yourself).


	self assert: md class equals: MidasEntityCollection.
	self assert: md entities size equals: 5.
	self assert: md entities first mockName equals: 'child11'.
	self assert: md entities last mockName equals: 'child23'.

	self assert: md entitiesWithAncestors size equals: 2.
	self assert: md entitiesWithAncestors first  key equals: entity1.
	self assert: md entitiesWithAncestors first value size equals: 2.
	self assert: md entitiesWithAncestors second key equals: entity2.
	self assert: md entitiesWithAncestors second value size equals: 3.
]

{ #category : #tests }
TestMidasEntitiesCollection >> testNextGenerationYieldEmpty [
	entity1 stub children willReturn: #().
	entity2 stub children willReturn: #().

	md := md	nextGenerationFromProperty:
					(MidasFM3PropertyForModels new
			 			selector: #children 
						yourself).


	self assert: md class equals: MidasEntityEmpty.
	self assert: md ancestor equals: { entity1 . entity2 }
]

{ #category : #tests }
TestMidasEntitiesCollection >> testNextGenerationYieldSingle [
	entity1 stub children willReturn: #( child ).
	entity2 stub children willReturn: #().

	md := md nextGenerationFromProperty:
					(MidasFM3PropertyForModels new
			 			selector: #children 
						yourself).


	self assert: md class equals: MidasEntityFamix.
	self assert: md entities size equals: 1.
	self assert: md entities first equals: #child.

	self assert: md ancestor equals: entity1.
]

{ #category : #tests }
TestMidasEntitiesCollection >> testPathsForFound [
	| search |
	md := MidasEntityCollection
				with: {
					#entity1 -> #( child11 child12 ) .
					#entity2 -> #( child21 child22 child23 ) }.

	search := MidasEntityCollection
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
	md := MidasEntityCollection
				with: {
					#entity1 -> #( child11 child12 ) .
					#entity2 -> #( child21 child22 child23 ) }.

	search := MidasEntityCollection
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
	md := MidasEntityCollection
				with: {
					entity1 -> { self mockEntity: 'child11' . self mockEntity: 'child12' } .
					entity2 -> { self mockEntity: 'child21' . self mockEntity: 'child22' . self mockEntity: 'child23' } }.

	self assert: (md selectEntitiesFromIndexes: #(0)) class equals: MidasEntityEmpty.

	self assert: (md selectEntitiesFromIndexes: #(1)) class equals: MidasEntityFamix.
	self assert: (md selectEntitiesFromIndexes: #(1)) entities size equals: 1.
	self assert: (md selectEntitiesFromIndexes: #(1)) entities first mockName equals: 'child11'.

	self assert: (md selectEntitiesFromIndexes: #(4)) class equals: MidasEntityFamix.
	self assert: (md selectEntitiesFromIndexes: #(4)) entities size equals: 1.
	self assert: (md selectEntitiesFromIndexes: #(4)) entities first mockName equals: 'child22'.

	self assert: (md selectEntitiesFromIndexes: #(2 5)) class equals: MidasEntityCollection.
	self assert: (md selectEntitiesFromIndexes: #(2 5)) entitiesWithAncestors size equals: 2.
	self assert: (md selectEntitiesFromIndexes: #(2 5)) entities size equals: 2.
	self assert: (md selectEntitiesFromIndexes: #(2 5)) entities first mockName equals: 'child12'.
	self assert: (md selectEntitiesFromIndexes: #(2 5)) entities second mockName equals: 'child23'.	

]

{ #category : #tests }
TestMidasEntitiesCollection >> testSelectEntitiesFromPaths [
	md := MidasEntityCollection
				with: {
					entity1 -> { self mockEntity: 'child11' . self mockEntity: 'child12'}  .
					entity2 -> { self mockEntity: 'child21' . self mockEntity: 'child22' . self mockEntity: 'child23' } }.

	self assert: (md selectEntitiesFromPaths: #( (1 1) )) entities size equals: 1.
	self assert: (md selectEntitiesFromPaths: #( (1 1) )) entities first mockName equals: 'child11'.

	self assert: (md selectEntitiesFromPaths: #( (2 1) )) entities size equals: 1.
	self assert: (md selectEntitiesFromPaths: #( (2 1) )) entities first mockName equals: 'child21'.

	self assert: (md selectEntitiesFromPaths: #( (1 2) (2 3) )) entitiesWithAncestors size equals: 2.
	self assert: (md selectEntitiesFromPaths: #( (1 2) (2 3) )) entities size equals: 2.
	self assert: (md selectEntitiesFromPaths: #( (1 2) (2 3) )) entities first mockName equals: 'child12'.
	self assert: (md selectEntitiesFromPaths: #( (1 2) (2 3) )) entities second mockName equals: 'child23'.

	self assert: (md selectEntitiesFromPaths: #( (1) )) entitiesWithAncestors size equals: 1.
	self assert: (md selectEntitiesFromPaths: #( (1) )) entities size equals: 2.
	self assert: (md selectEntitiesFromPaths: #( (1) )) entities first mockName
			equals: 'child11'.
	self assert: (md selectEntitiesFromPaths: #( (1) )) entities second mockName
			equals: 'child12'.

	self assert: (md selectEntitiesFromPaths: #( (1) (2 3) )) entitiesWithAncestors size equals: 2.
	self assert: (md selectEntitiesFromPaths: #( (1) (2 3) )) entities size equals: 3.
	self assert: (md selectEntitiesFromPaths: #( (1) (2 3) )) entities first mockName
			equals: 'child11'.
	self assert: (md selectEntitiesFromPaths: #( (1) (2 3) )) entities second mockName
			equals: 'child12'.
	self assert: (md selectEntitiesFromPaths: #( (1) (2 3) )) entities third mockName
			equals: 'child23'.

]
