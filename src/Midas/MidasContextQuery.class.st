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
	^ false
]

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

{ #category : #accessing }
MidasContextQuery >> flattenResult [
	resultsWithParents := false.
	self notifyStrongFocus: nil
]

{ #category : #notifications }
MidasContextQuery >> formatNewStrongFocus: focus [
	^MidasFocusFormater new format: focus
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
MidasContextQuery >> methodScope [
	self strongFocus: (self toScope: 'FAMIXMethod')
]

{ #category : #accessing }
MidasContextQuery >> next [
	parentContext next
]

{ #category : #running }
MidasContextQuery >> packageScope [
	self strongFocus: (self atScope: 'FAMIXNamespace')
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

{ #category : #notifications }
MidasContextQuery >> selectedStrongFocus: aMidasEntity [
	self strongFocus: aMidasEntity selection
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

{ #category : #running }
MidasContextQuery >> toScope: aSymbol [
	^ self runCollectQuery: (MVSFilterManager new buildQueryBlockFrom: 'each toScope: ' , aSymbol).
	
]

{ #category : #accessing }
MidasContextQuery >> trackAssociation [
	resultsWithParents := true.
	self notifyStrongFocus: nil
]
