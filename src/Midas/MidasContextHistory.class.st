Class {
	#name : #MidasContextHistory,
	#superclass : #MidasChildContext,
	#instVars : [
		'history'
	],
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextHistory >> acceptWeakFocusUpdate: newFocus [
	^ false
]

{ #category : #history }
MidasContextHistory >> addToHistory: anEntry [
	history add: anEntry
]

{ #category : #history }
MidasContextHistory >> current [
	^history now
]

{ #category : #history }
MidasContextHistory >> history [
	^ history entries
]

{ #category : #history }
MidasContextHistory >> historyHasNext [ 
	^ history hasNext
]

{ #category : #history }
MidasContextHistory >> historyHasPrevious [ 
	^ history hasPrevious 
]

{ #category : #initialization }
MidasContextHistory >> initHistory [ 
	history := MidasHistory new.
	history addEntry: self mooseModel
]

{ #category : #initialization }
MidasContextHistory >> initialize [
	super initialize.
	history := MidasHistory new.
]

{ #category : #history }
MidasContextHistory >> next [
	history hasNext ifFalse: [ ^ self ].
	self strongFocusFromHistory: history next.
	app updatePreviousNext
]

{ #category : #history }
MidasContextHistory >> nextInHistory: entry [
	^history nextInHistory: entry

]

{ #category : #notifications }
MidasContextHistory >> notifyStrongFocus: newFocus [
	self addToHistory: newFocus.
	app refresh
]

{ #category : #history }
MidasContextHistory >> prev [
	history hasPrevious ifFalse: [ ^ self ].
	self strongFocusFromHistory: history previous.
	app updatePreviousNext
]

{ #category : #notifications }
MidasContextHistory >> selected: anHistoryentry [
	self strongFocus: anHistoryentry key
]

{ #category : #history }
MidasContextHistory >> strongFocusFromHistory: newFocus [
	| cachedFrozen |
	cachedFrozen := frozen.
	frozen := false.
	self strongFocus: newFocus.
	self notifyStrongFocus: newFocus.
	frozen := cachedFrozen
]

{ #category : #history }
MidasContextHistory >> summaryDescriptionFor: entry [
	| stream size |
	stream := WriteStream on: String new.
	size := 0.
	entry key
		do: [ :entity | 
			size := size + entity name size.
			(size < 100)
				ifTrue: [
					stream nextPutAll: entity name.
					stream cr
				]
			ifFalse: [
				stream nextPutAll: '...'.
				^ stream contents
			]
		 ].
	^stream contents
]
