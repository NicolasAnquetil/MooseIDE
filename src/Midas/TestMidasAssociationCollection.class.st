Class {
	#name : #TestMidasAssociationCollection,
	#superclass : #AbstractTestMidasEntities,
	#instVars : [
		'md'
	],
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestMidasAssociationCollection >> testAncestorOfAssociation [
	| assoc |
	assoc := self mockAssociation: #anAssoc.
	md := MidasEntityFamixAssociation with: { #ancestor -> { assoc } }.

	"fake #collect: that will return a collection of entities"	
	md := md nextGenerationFromCollect: [ :each | { self mockEntity: 'child' } ].
	
	self assert: md ancestors size equals: 1.
	self assert: md ancestors first equals: #ancestor.
	self assert: md entities size equals: 1.
	self assert: md entities first mockName equals: 'child'.

]
