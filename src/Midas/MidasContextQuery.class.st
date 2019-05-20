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

{ #category : #accessing }
MidasContextQuery >> flattenResult [
	resultsWithParents := false.
	self notifyStrongFocus: nil
]

{ #category : #notifications }
MidasContextQuery >> formatNewFocus: focus [
	^ self strongFocus collect: [ :e | MidasQueryResult with: e from: nil ]
]

{ #category : #notifications }
MidasContextQuery >> formatNewModel: mooseModel [
	| formated |
	formated := OrderedCollection new.
	(self mooseModelAsGroups: mooseModel)
		associationsDo: [ :assoc |
			(assoc key asString beginsWith: 'All model')
			ifTrue: [
				formated add:
					((MidasQueryResultUnnamed with: assoc value from: mooseModel)
						name: assoc key ;
						yourself)
			]
		].
	^formated 
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
MidasContextQuery >> interpretQuery: aBlockAsString [
	| aBlock |
	aBlock := MVSFilterManager new buildQueryBlockFrom: aBlockAsString.
	self strongFocus:
		(app filterQuery
					ifTrue: [ self runSelectQuery: aBlock ]
					ifFalse: [ self runCollectQuery: aBlock])
	
]

{ #category : #running }
MidasContextQuery >> mooseModelAsGroups: mooseModel [
	^ mooseModel entityCache
]

{ #category : #accessing }
MidasContextQuery >> next [
	parentContext next
]

{ #category : #accessing }
MidasContextQuery >> prev [
	parentContext previous
]

{ #category : #accessing }
MidasContextQuery >> resultsWithParents [
	^resultsWithParents
]

{ #category : #running }
MidasContextQuery >> runCollectQuery: aBloc [
	^self strongFocus flatCollect: aBloc.

	
]

{ #category : #running }
MidasContextQuery >> runSelectQuery: aBloc [
	^self strongFocus select: aBloc.

	
]

{ #category : #running }
MidasContextQuery >> selectedStrongFocus: aMidasEntity [
	self strongFocus: aMidasEntity entity
]

{ #category : #running }
MidasContextQuery >> selectedWeakFocus: aMidasEntity [
	aMidasEntity ifNil: [ ^ self ].
	self weakFocus: aMidasEntity entity
]

{ #category : #accessing }
MidasContextQuery >> strongFocus [
	| realFocus |
	realFocus := super strongFocus.
	^realFocus isCollection
		ifTrue: [ realFocus ]
		ifFalse: [ OrderedCollection with: realFocus ]
]

{ #category : #accessing }
MidasContextQuery >> trackAssociation [
	resultsWithParents := true.
	self notifyStrongFocus: nil
]
