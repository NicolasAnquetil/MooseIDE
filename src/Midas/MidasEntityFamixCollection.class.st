"
I am a MidasEntity containing alist of Famix entities

"
Class {
	#name : #MidasEntityFamixCollection,
	#superclass : #MidasEntityAbstract,
	#instVars : [
		'name',
		'entities'
	],
	#category : #'Midas-context'
}

{ #category : #'as yet unclassified' }
MidasEntityFamixCollection class >> with: aCollection [
	| nbEntities |
	nbEntities := aCollection inject: 0 into: [ :sum :each | sum + each value size ].
	^self with: aCollection named: (nbEntities asString , ' entities')
]

{ #category : #'as yet unclassified' }
MidasEntityFamixCollection class >> with: aCollection named: aString [
	^self new
		entities: aCollection ;
		name: aString ;
		ancestor: nil ;
		yourself
]

{ #category : #formatting }
MidasEntityFamixCollection >> displayString [
	^ self name
]

{ #category : #formatting }
MidasEntityFamixCollection >> entities [
	^ entities flatCollect: #value
]

{ #category : #initialization }
MidasEntityFamixCollection >> entities: aCollection [
	entities := aCollection 
]

{ #category : #formatting }
MidasEntityFamixCollection >> entitiesWithAncestors [
	^ entities
]

{ #category : #running }
MidasEntityFamixCollection >> filterNextGeneration: nextGeneration [
	| filteredGeneration |
	filteredGeneration := nextGeneration reject: [ :nextAssoc | nextAssoc value isEmpty ].

	filteredGeneration ifEmpty: [ ^ MidasEntityEmpty ancestor: self entities ].
	((filteredGeneration size = 1) and: [ filteredGeneration first value size = 1 ])
		ifTrue: [ ^ MidasEntityFamix
							with: filteredGeneration first value first
							ancestor: filteredGeneration first key
					].

	^ MidasEntityFamixCollection with: filteredGeneration
]

{ #category : #running }
MidasEntityFamixCollection >> indexInListWithoutAncestors: index [
	| realIndex nbEntities |
	nbEntities := 0.
	realIndex := index - 1. "first ancestor is not counted"
	entities do: [ :assoc |
		nbEntities := nbEntities + assoc value size.
		(nbEntities < realIndex)
			ifTrue: [ realIndex := realIndex -1 "next ancestor is not counted"]
	].
	^ realIndex 
]

{ #category : #initialization }
MidasEntityFamixCollection >> name [
	^ name
]

{ #category : #initialization }
MidasEntityFamixCollection >> name: aString [
	name := aString
]

{ #category : #'instance creation' }
MidasEntityFamixCollection >> nextGenerationSelector: aSelector [
	| nextGeneration |
	nextGeneration := entities flatCollect: [ :assoc |
								assoc value collect: [ :each | each -> (each perform: aSelector) ]
							].
	^ self filterNextGeneration: nextGeneration
	
]

{ #category : #running }
MidasEntityFamixCollection >> selectEntitiesIndexed: indexes [
	| nextGeneration nbEntities |
	nbEntities := 0.
	nextGeneration := entities collect: [ :assoc || myIndexes |
								myIndexes := indexes collect: [ :i | i - nbEntities ].
								myIndexes := myIndexes reject: [ :i | i < 1 or: [ i > assoc value size ] ].
								nbEntities := nbEntities + assoc value size.
								assoc key -> myIndexes collect: [ :i | assoc value at: i ].
							].

	^ self filterNextGeneration: nextGeneration
	
]
