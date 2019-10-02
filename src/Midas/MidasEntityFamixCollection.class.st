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
	#category : #'Midas-focusModel'
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

{ #category : #accessing }
MidasEntityFamixCollection >> entities: aCollection [
	entities := aCollection 
]

{ #category : #accessing }
MidasEntityFamixCollection >> entitiesWithAncestors [
	^ entities
]

{ #category : #testing }
MidasEntityFamixCollection >> isCollection [
	^ true
]

{ #category : #accessing }
MidasEntityFamixCollection >> name [
	^ name
]

{ #category : #accessing }
MidasEntityFamixCollection >> name: aString [
	name := aString
]

{ #category : #private }
MidasEntityFamixCollection >> selectEntitiesIndexed: indexes [
	| nextGeneration nbEntities |
	nbEntities := 0.
	nextGeneration := entities collect: [ :assoc || myIndexes |
								myIndexes := indexes collect: [ :i | i - nbEntities ].
								myIndexes := myIndexes reject: [ :i | i < 1 or: [ i > assoc value size ] ].
								nbEntities := nbEntities + assoc value size.
								assoc key -> (myIndexes collect: [ :i | assoc value at: i ]).
							].

	^ self filterNextGeneration: nextGeneration
	
]

{ #category : #private }
MidasEntityFamixCollection >> selectPathsIndexed: indexes [
	| nextGeneration ancestorsIndexes |
	ancestorsIndexes := indexes groupedBy: #first.
	nextGeneration := OrderedCollection new: entities size.
	ancestorsIndexes keysAndValuesDo:  [ :ascendantIndex :descendantsIndexes |
								| currentEntity descendants |
								currentEntity := entities at: ascendantIndex.
								descendants := descendantsIndexes collect: [ :duplet |
														currentEntity value at: duplet second].
								nextGeneration add: (currentEntity key -> descendants)
							].
	^ self filterNextGeneration: nextGeneration
	
]
