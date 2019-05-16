Class {
	#name : #MidasContextQuery,
	#superclass : #MidasChildContext,
	#instVars : [
		'resultsWithParents',
		'listEntities'
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
	self notifyStrongFocus: self flattenedStrongFocus 
]

{ #category : #notifications }
MidasContextQuery >> formatNewFocus: focus [
	^self strongFocusIsModel 
		ifTrue: [ 
			resultsWithParents 
				ifTrue: [ self formatNewFocusWithParents: { self mooseModel -> self mooseModelAsGroups } ]
				ifFalse: [ self formatNewFocusFlat: self mooseModelAsGroups ] ]
		ifFalse: [
			resultsWithParents 
				ifTrue: [ self formatNewFocusWithParents: self strongFocus ]
				ifFalse: [ self formatNewFocusFlat: focus ] ]
]

{ #category : #notifications }
MidasContextQuery >> formatNewFocusFlat: focus [
	^focus collect: [ :each | each -> each ]
]

{ #category : #notifications }
MidasContextQuery >> formatNewFocusWithParents: focus [
	|entitiesToDisplay|
	entitiesToDisplay := OrderedCollection new.
	focus associationsDo: [:asso |
		entitiesToDisplay add: asso key -> asso key.
		entitiesToDisplay addAll: (asso value collect: [:each | asso key -> each])  ].
	^entitiesToDisplay
]

{ #category : #history }
MidasContextQuery >> historyHasNext [
	^parentContext historyHasNext
]

{ #category : #history }
MidasContextQuery >> historyHasPrevious [
	^parentContext historyHasPrevious
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

{ #category : #running }
MidasContextQuery >> next [
	parentContext next
]

{ #category : #notifications }
MidasContextQuery >> notifyNewModel: newMooseModel [
	app updateStrongFocus: (self formatNewFocus: (self mooseModelAsGroups))
]

{ #category : #running }
MidasContextQuery >> prev [
	parentContext previous
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
			) associationsSelect: [ :a | a value = anEntity value ])
]

{ #category : #running }
MidasContextQuery >> selectedWeakFocus: anEntity [
	self weakFocus: anEntity value
]

{ #category : #running }
MidasContextQuery >> trackAssociation [
	resultsWithParents := true.
	self notifyStrongFocus: nil "not used in this situation"
]
