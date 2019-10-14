Class {
	#name : #TestMidasEntitiesEmpty,
	#superclass : #AbstractTestMidasEntities,
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestMidasEntitiesEmpty >> testIsModel [
	self deny: MidasEntityEmpty new isModel
]

{ #category : #tests }
TestMidasEntitiesEmpty >> testNextGenerationSelector [
	| md |
	md := (MidasEntityEmpty ancestor: nil)
				nextGenerationFromProperty:
					(MidasFM3PropertyForModels new
			 			selector: #whatever 
						yourself).

	self assert: md class equals: MidasEntityEmpty
]

{ #category : #tests }
TestMidasEntitiesEmpty >> testSameModel [
	| m1 m2 |
	m1 := MooseModel new.
	m2 := MooseModel new.

	self deny: (MidasEntityEmpty new sameModel: m1).
]

{ #category : #tests }
TestMidasEntitiesEmpty >> testSelectIndexed [
	| md |
	md := (MidasEntityEmpty ancestor: #anAncestor).

	self assert: (md selectEntitiesFromIndexes: #(0)) class equals: MidasEntityEmpty.
	self assert: (md selectEntitiesFromIndexes: #(1)) class equals: MidasEntityEmpty.
]
