Class {
	#name : #MidasContextQuery,
	#superclass : #MidasChildContext,
	#instVars : [
		'resultsWithParents'
	],
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextQuery >> acceptModelUpdate: newFocus [
	^ true
]

{ #category : #running }
MidasContextQuery >> flattenResult [
	resultsWithParents := false.
]

{ #category : #initialization }
MidasContextQuery >> initialize [
	super initialize.
	resultsWithParents := false.
]

{ #category : #running }
MidasContextQuery >> interpretQuery: aPredicateAsString withBody: aBlockAsString [
	| aBlock |
	aBlock := MVSFilterManager new buildQueryBlockFrom: aBlockAsString.
	self strongFocus:
		(aPredicateAsString = 'filter'
					ifTrue: [ self runSelectQuery: aBlock ]
					ifFalse: [ self runCollectQuery: aBlock])
	
]

{ #category : #notifications }
MidasContextQuery >> notifyNewModel: newMooseModel [
	app updateStrongFocus: (self mooseModelAsGroups)
]

{ #category : #running }
MidasContextQuery >> runCollectQuery: aBloc [
	| focus |
	focus := Dictionary new.
	self flattenedStrongFocus do: [ :key | focus at: key put: (aBloc value: key) ].
	^focus

	
]

{ #category : #running }
MidasContextQuery >> runSelectQuery: aBloc [
	| focus |
	focus := Dictionary new.
	self strongFocus associationsDo: [:asso |
		(asso value select: aBloc)
			ifNotEmpty: [ :newValue | focus at: asso key put: newValue ]
		].
	^focus

	
]

{ #category : #running }
MidasContextQuery >> selectedStrongFocus: anEntity [
	self strongFocus:
		((self strongFocusIsModel 
			ifTrue: [ self mooseModelAsGroups ]
			ifFalse: [ self strongFocus ]
			) associationsSelect: [ :a | a value = anEntity ])
]

{ #category : #running }
MidasContextQuery >> selectedWeakFocus: anEntity [
	self weakFocus: anEntity
]

{ #category : #running }
MidasContextQuery >> trackAssociation [
	resultsWithParents := true.
]
