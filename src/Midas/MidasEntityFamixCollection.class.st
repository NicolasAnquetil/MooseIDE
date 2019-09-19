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

{ #category : #private }
MidasEntityFamixCollection >> indexInListWithoutAncestors: index [
	| nbEntities nbAncestors |
	(index < 1) ifTrue: [ ^ 0 ].
	nbEntities := 0.
	nbAncestors := 0.
	entities do: [ :assoc |
		nbAncestors := nbAncestors + 1.
		((nbEntities + nbAncestors) = index)
			ifTrue: [ ^ 0 ]
			ifFalse: [
				nbEntities := nbEntities + assoc value size.
				((nbEntities + nbAncestors) >= index)
				ifTrue: [ ^ index - nbAncestors ]
			]
	].
	((nbEntities + nbAncestors) < index)
			ifTrue: [ ^ 0 ]
			ifFalse: [ ^ index - nbAncestors ]
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
