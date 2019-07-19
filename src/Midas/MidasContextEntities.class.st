"
Context for EntitiesApp
"
Class {
	#name : #MidasContextEntities,
	#superclass : #MidasChildContext,
	#instVars : [
		'resultsWithParents',
		'listEntities',
		'history'
	],
	#category : #'Midas-context'
}

{ #category : #history }
MidasContextEntities >> addToHistory: anEntry [
	history add: anEntry.
	app updatePreviousNext 
]

{ #category : #running }
MidasContextEntities >> atScope: aSymbol [
	^ (self runCollectQuery: (MVSFilterManager new buildQueryBlockFrom: 'each atScope: ' , aSymbol))
			removeDuplicates.
	
]

{ #category : #running }
MidasContextEntities >> classScope [
	| actuel |
	actuel := self strongFocus.
	actuel ifEmpty: [ ^ nil ].
	actuel anyOne isMethod
		ifTrue: [ self strongFocus: (self atScope: 'FAMIXClass') ]
		ifFalse: [ self strongFocus: (self toScope: 'FAMIXClass') ].
]

{ #category : #accessing }
MidasContextEntities >> flattenResult [
	resultsWithParents := false.
	self notifyStrongFocus: nil
]

{ #category : #notifications }
MidasContextEntities >> formatNewModel: mooseModel [
	self initHistory.
	^ 	{MidasEntityTransparent with: mooseModel}
]

{ #category : #notifications }
MidasContextEntities >> formatNewStrongFocus: focus [
	(focus = self mooseModel)
		ifTrue: [ ^ {MidasEntityTransparent with: focus} ].
	focus isCollection 
		ifTrue: [ ^ focus collect: [ :each | MidasEntityTransparent with: each] ].
	^ {MidasEntityTransparent with: focus}
]

{ #category : #history }
MidasContextEntities >> historyHasNext [ 
	^ history hasNext
]

{ #category : #history }
MidasContextEntities >> historyHasPrevious [ 
	^ history hasPrevious 
]

{ #category : #initialization }
MidasContextEntities >> initHistory [ 
	history := MidasHistory new.
	history addEntry: self mooseModel
]

{ #category : #initialization }
MidasContextEntities >> initialize [
	super initialize.
	resultsWithParents := false.
	history := MidasHistory new
]

{ #category : #running }
MidasContextEntities >> interpretQuery: aBlockAsString [
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
MidasContextEntities >> methodScope [
	self strongFocus: (self toScope: 'FAMIXMethod')
]

{ #category : #history }
MidasContextEntities >> next [
	history hasNext
		ifTrue: [ self strongFocusFromHistory: history next.
			app updatePreviousNext ]
]

{ #category : #running }
MidasContextEntities >> packageScope [
	self strongFocus: (self atScope: 'FAMIXPackage')
]

{ #category : #accessing }
MidasContextEntities >> parentContext: aContext [
	super parentContext:aContext.
		self initHistory.
]

{ #category : #history }
MidasContextEntities >> prev [
	history hasPrevious
		ifTrue: [ self strongFocusFromHistory: history previous.
			app updatePreviousNext ]
]

{ #category : #accessing }
MidasContextEntities >> resultsWithParents [
	^resultsWithParents
]

{ #category : #running }
MidasContextEntities >> runCollectQuery: aBloc [
	^self strongFocus flatCollect: aBloc.

	
]

{ #category : #running }
MidasContextEntities >> runSelectQuery: aBloc [
	^ self strongFocus select: aBloc
]

{ #category : #notifications }
MidasContextEntities >> selectedStrongFocus: aMidasEntity [
	| wasFrozen |
	wasFrozen := frozen.
	frozen := false.
	self strongFocus: aMidasEntity selection.
	self addToHistory: aMidasEntity selection.
	frozen := wasFrozen
]

{ #category : #notifications }
MidasContextEntities >> selectedWeakFocus: aMidasEntity [
	aMidasEntity ifNil: [ ^ self ].
	self weakFocus: aMidasEntity selection
]

{ #category : #accessing }
MidasContextEntities >> strongFocus [
	| realFocus |
	realFocus := super strongFocus.
	^realFocus isCollection
		ifTrue: [ realFocus ]
		ifFalse: [ OrderedCollection with: realFocus ]
]

{ #category : #history }
MidasContextEntities >> strongFocusFromHistory: newFocus [
	| cachedFrozen |
	cachedFrozen := frozen.
	frozen := false.
	self strongFocus: newFocus.
	self notifyStrongFocus: newFocus.
	frozen := cachedFrozen
]

{ #category : #running }
MidasContextEntities >> toScope: aSymbol [
	^ self runCollectQuery: (MVSFilterManager new buildQueryBlockFrom: 'each toScope: ' , aSymbol).
	
]

{ #category : #accessing }
MidasContextEntities >> trackAssociation [
	resultsWithParents := true.
	self notifyStrongFocus: nil
]
