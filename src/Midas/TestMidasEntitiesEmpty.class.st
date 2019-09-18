Class {
	#name : #TestMidasEntitiesEmpty,
	#superclass : #TestMidasEntities,
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestMidasEntitiesEmpty >> testIndexWithAncestors [
	| md |
	md := (MidasEntityEmpty ancestor: #anAncestor).

	self assert: (md indexInListWithoutAncestors: 0) equals: 0.
	self assert: (md indexInListWithoutAncestors: 1) equals: 0.
	self assert: (md indexInListWithoutAncestors: 2) equals: 0.
	self assert: (md indexInListWithoutAncestors: 3) equals: 0.
]

{ #category : #tests }
TestMidasEntitiesEmpty >> testIsModel [
	self deny: MidasEntityEmpty new isModel
]

{ #category : #tests }
TestMidasEntitiesEmpty >> testNextGenerationSelector [
	| md |
	md := (MidasEntityEmpty ancestor: nil)
				nextGenerationSelector: #whatever.

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

	self assert: (md selectEntitiesIndexed: #(0)) class equals: MidasEntityEmpty.
	self assert: (md selectEntitiesIndexed: #(1)) class equals: MidasEntityEmpty.
]
