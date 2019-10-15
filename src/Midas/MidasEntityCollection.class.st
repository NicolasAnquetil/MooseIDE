"
I am a MidasEntity containing alist of Famix entities

"
Class {
	#name : #MidasEntityCollection,
	#superclass : #MidasEntityAbstract,
	#instVars : [
		'name',
		'entities'
	],
	#category : #'Midas-focusModel'
}

{ #category : #'as yet unclassified' }
MidasEntityCollection class >> with: aCollection [
	| nbEntities |
	nbEntities := aCollection inject: 0 into: [ :sum :each | sum + each value size ].
	^self with: aCollection named: (nbEntities asString , ' entities')
]

{ #category : #'as yet unclassified' }
MidasEntityCollection class >> with: aCollection named: aString [
	^self new
		entities: aCollection ;
		name: aString ;
		ancestor: nil ;
		yourself
]

{ #category : #formatting }
MidasEntityCollection >> ancestors [
	^ entities collect: #key
]

{ #category : #accessing }
MidasEntityCollection >> childrenFor: anAncestor [
	^entities
		detect: [ :assoc | assoc key = anAncestor ]
		ifFound: [ :assoc | assoc value ]
		ifNone: [ #() ]
]

{ #category : #formatting }
MidasEntityCollection >> displayString [
	^ self name
]

{ #category : #accessing }
MidasEntityCollection >> entities [
	^ entities flatCollect: #value
]

{ #category : #accessing }
MidasEntityCollection >> entities: aCollection [
	entities := aCollection 
]

{ #category : #accessing }
MidasEntityCollection >> entitiesWithAncestors [
	^ entities
]

{ #category : #indexing }
MidasEntityCollection >> indexFor: searchedEntities in: aCollection [
	"re-implementing OrderedCollection>>indexOf: because our collectin can be a MooseGroup
	 and I am toolazy to go into that and add it"
	| index |
	index := 1.
	aCollection do: [:elt |
		elt = searchedEntities
			ifTrue: [^ index].
		index := index+1
	].
	^ 0
]

{ #category : #indexing }
MidasEntityCollection >> indicesFor: searchedEntities in: aCollection [
	| found |
	found := OrderedCollection new: searchedEntities size.
	searchedEntities do: [ :searchedEntity || i |
		i := (self indexFor: searchedEntity in: aCollection).
		(i > 0)
			ifTrue: [ found add: i ]
	].
	^found
]

{ #category : #testing }
MidasEntityCollection >> isCollection [
	^ true
]

{ #category : #accessing }
MidasEntityCollection >> name [
	^ name
]

{ #category : #accessing }
MidasEntityCollection >> name: aString [
	name := aString
]

{ #category : #indexing }
MidasEntityCollection >> pathsFor: searchedEntities [
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
MidasEntityCollection >> selectEntitiesFromIndexes: indexes [
	| nextGeneration nbEntities |
	nbEntities := 0.
	nextGeneration := entities collect: [ :assoc || myIndexes |
								myIndexes := indexes collect: [ :i | i - nbEntities ].
								myIndexes := myIndexes reject: [ :i | i < 1 or: [ i > assoc value size ] ].
								nbEntities := nbEntities + assoc value size.
								assoc key -> (myIndexes collect: [ :i | assoc value at: i ]).
							].

	^ self nextGenerationFromCollection: nextGeneration
	
]

{ #category : #indexing }
MidasEntityCollection >> selectEntitiesFromPaths: indexes [
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
	^ self nextGenerationFromCollection: nextGeneration
	
]
