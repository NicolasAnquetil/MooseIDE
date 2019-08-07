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

{ #category : #history }
MidasContextQuery >> addToHistory: anEntry [
	history add: anEntry.
	app updatePreviousNext 
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
	actuel ifEmpty: [ ^ nil ].
	actuel anyOne isMethod
		ifTrue: [ self strongFocus: (self atScope: 'FAMIXClass') ]
		ifFalse: [ self strongFocus: (self toScope: 'FAMIXClass') ].
]

{ #category : #accessing }
MidasContextQuery >> flattenResult [
	resultsWithParents := false.
	 self notifyStrongFocus: nil
]

{ #category : #notifications }
MidasContextQuery >> formatNewModel: mooseModel [
	self initHistory.
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

{ #category : #initialization }
MidasContextQuery >> initHistory [ 
	history := MidasHistory new.
	history addEntry: self mooseModel
]

{ #category : #initialization }
MidasContextQuery >> initialize [
	super initialize.
	resultsWithParents := false.
	history := MidasHistory new
]

{ #category : #running }
MidasContextQuery >> interpretQuery: aBlockAsString [
	| aBlock |
	aBlockAsString
		ifEmpty: [
			self notifyStrongFocus: history now ]
		ifNotEmpty: [ aBlock := MVSFilterManager new buildQueryBlockFrom: aBlockAsString.
			self
				strongFocus:
					(app filterQuery
						ifTrue: [ self runSelectQuery: aBlock ]
						ifFalse: [ self runCollectQuery: aBlock ]) ]
]

{ #category : #running }
MidasContextQuery >> methodScope [
	self strongFocus: (self toScope: 'FAMIXMethod')
]

{ #category : #history }
MidasContextQuery >> next [
	history hasNext
		ifTrue: [ self strongFocusFromHistory: history next.
			app updatePreviousNext ]
]

{ #category : #running }
MidasContextQuery >> packageScope [
	self strongFocus: (self atScope: 'FAMIXPackage')
]

{ #category : #accessing }
MidasContextQuery >> parentContext: aContext [
	super parentContext:aContext.
		self initHistory.
]

{ #category : #history }
MidasContextQuery >> prev [
	history hasPrevious
		ifTrue: [ self strongFocusFromHistory: history previous.
			app updatePreviousNext ]
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
	^ self strongFocus select: aBloc
]

{ #category : #notifications }
MidasContextQuery >> selectedStrongFocus: aMidasEntity [
	| wasFrozen |
	wasFrozen := frozen.
	frozen := false.
	self strongFocus: aMidasEntity selection.
	self addToHistory: aMidasEntity selection.
	frozen := wasFrozen
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

{ #category : #history }
MidasContextQuery >> strongFocusFromHistory: newFocus [
	| cachedFrozen |
	cachedFrozen := frozen.
	frozen := false.
	self strongFocus: newFocus.
	self notifyStrongFocus: newFocus.
	frozen := cachedFrozen
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
