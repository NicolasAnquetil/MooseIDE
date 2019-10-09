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
MidasEntityFamixCollection >> ancestors [
	^ entities collect: #key
]

{ #category : #accessing }
MidasEntityFamixCollection >> childrenFor: anAncestor [
	^entities
		detect: [ :assoc | assoc key = anAncestor ]
		ifFound: [ :assoc | assoc value ]
		ifNone: [ #() ]
]

{ #category : #formatting }
MidasEntityFamixCollection >> displayString [
	^ self name
]

{ #category : #accessing }
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

{ #category : #indexing }
MidasEntityFamixCollection >> indicesFor: searchedEntities in: aCollection [
	| found |
	found := OrderedCollection new: searchedEntities size.
	searchedEntities do: [ :searchedEntity || i |
		i := aCollection indexOf: searchedEntity.
		(i = 0)
			ifFalse: [ found add: i ]
	].
	^found
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

{ #category : #indexing }
MidasEntityFamixCollection >> pathsFor: searchedEntities [
	| paths i searched |
	paths := OrderedCollection new: searchedEntities size.
	searched := searchedEntities entitiesWithAncestors.
	i := 0.
	self entitiesWithAncestors do: [ :myAssoc |
		i := i+1.
		searched
			detect: [ :searchedAssoc | searchedAssoc key = myAssoc key]
			ifFound: [ :searchedAssoc |
				(self indicesFor: searchedAssoc value in: myAssoc value )
					ifNotEmpty: [ :indices | paths addAll: (indices collect: [ :j | { i . j } ]) ]
			].
	].
^paths
]

{ #category : #indexing }
MidasEntityFamixCollection >> selectEntitiesFromIndexes: indexes [
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

{ #category : #indexing }
MidasEntityFamixCollection >> selectEntitiesFromPaths: indexes [
	| nextGeneration ancestorsIndexes |
	ancestorsIndexes := indexes groupedBy: #first.
	nextGeneration := OrderedCollection new: entities size.
	ancestorsIndexes keysAndValuesDo:  [ :ascendantIndex :ascendantPaths |
		| currentEntity descendants |
		currentEntity := entities at: ascendantIndex.
		descendants := (ascendantPaths contains: [ :path | path size = 1 ])
			ifTrue: [ "if paths include an ancestor, then select all of its descendant"
				currentEntity value ]
			ifFalse: [
				ascendantPaths collect: [ :duplet | currentEntity value at: duplet second ]
			].				
		nextGeneration add: (currentEntity key -> descendants)
	].
	^ self filterNextGeneration: nextGeneration
	
]
