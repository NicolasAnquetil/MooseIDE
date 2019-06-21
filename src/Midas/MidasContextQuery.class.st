Class {
	#name : #MidasContextQuery,
	#superclass : #MidasChildContext,
	#instVars : [
		'resultsWithParents',
		'listEntities',
		'history'
	],
	#category : #'Midas-context'
}

{ #category : #running }
MidasContextQuery >> atScope: aSymbol [
	^ (self runCollectQuery: (MVSFilterManager new buildQueryBlockFrom: 'each atScope: ' , aSymbol))
			removeDuplicates.
	
]

{ #category : #running }
MidasContextQuery >> classScope [
	| actuel |
	actuel := self strongFocus.
	actuel
		ifEmpty: [ ^ nil ] .
	actuel anyOne isMethod
		ifTrue: [ self strongFocus: (self atScope: 'FAMIXClass') ]
		ifFalse: [ self strongFocus: (self toScope: 'FAMIXClass') ]

]

{ #category : #history }
MidasContextQuery >> clearHistory [
	history := MidasHistory new.
	self weakFocus: nil
]

{ #category : #accessing }
MidasContextQuery >> flattenResult [
	resultsWithParents := false.
	self notifyStrongFocus: nil
]

{ #category : #notifications }
MidasContextQuery >> formatNewModel: mooseModel [
	^ self formatNewStrongFocus: mooseModel
]

{ #category : #notifications }
MidasContextQuery >> formatNewStrongFocus: focus [
	^MidasFocusFormater new format: focus
]

{ #category : #history }
MidasContextQuery >> historyHasNext [
	^ history hasNext
]

{ #category : #history }
MidasContextQuery >> historyHasPrevious [
	^ history hasPrevious
]

{ #category : #history }
MidasContextQuery >> initHistoryWith: newMooseModel [
	self clearHistory.
	history addEntry: newMooseModel
]

{ #category : #initialization }
MidasContextQuery >> initialize [
	super initialize.
	resultsWithParents := false.
		self clearHistory
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
MidasContextQuery >> methodScope [
	self strongFocus: (self toScope: 'FAMIXMethod')
]

{ #category : #accessing }
MidasContextQuery >> next [
	history hasNext
		ifTrue: [ self strongFocusFromHistory: history next ]
]

{ #category : #running }
MidasContextQuery >> packageScope [
	self strongFocus: (self atScope: 'FAMIXNamespace')
]

{ #category : #accessing }
MidasContextQuery >> prev [
		history hasPrevious
		ifTrue: [ self strongFocusFromHistory: history previous ]
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

{ #category : #notifications }
MidasContextQuery >> selectedStrongFocus: aMidasEntity [
	self strongFocus: aMidasEntity selection.
	app updateStrongFocus: (self formatNewStrongFocus: aMidasEntity selection) 
]

{ #category : #notifications }
MidasContextQuery >> selectedWeakFocus: aMidasEntity [
	aMidasEntity ifNil: [ ^ self ].
	self weakFocus: aMidasEntity selection
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
MidasContextQuery >> strongFocusIsModel [
	^history hasPrevious not
]

{ #category : #running }
MidasContextQuery >> toScope: aSymbol [
	^ self runCollectQuery: (MVSFilterManager new buildQueryBlockFrom: 'each toScope: ' , aSymbol).
	
]

{ #category : #accessing }
MidasContextQuery >> trackAssociation [
	resultsWithParents := true.
	self notifyStrongFocus: nil
]
