"
Context for AppHistory
Stores all the entites resulting from user actionsHolder
Allows to navigate the history
"
Class {
	#name : #MidasContextHistory,
	#superclass : #MidasChildContext,
	#instVars : [
		'history',
		'paused'
	],
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextHistory >> acceptStrongFocusUpdate: newFocus [
	^ paused
]

{ #category : #history }
MidasContextHistory >> addToHistory: entities [
	(self focusIsMooseModel: entities)
		ifTrue: [ history addEntryModel: entities ]
		ifFalse: [ history addEntry: entities ]
	
]

{ #category : #accessing }
MidasContextHistory >> allEntries [
	^ history allEntries
]

{ #category : #history }
MidasContextHistory >> current [
	^history currentEntry
]

{ #category : #history }
MidasContextHistory >> currentName [
	^history currentName
]

{ #category : #history }
MidasContextHistory >> currentName: aString [
	history currentName: aString
]

{ #category : #history }
MidasContextHistory >> gotoEntry [
	paused := true.
	self midasFocus: history currentEntry value.
	paused := false.
	app refresh
]

{ #category : #history }
MidasContextHistory >> gotoEntry: anHistoryEntry [
	history currentEntry: anHistoryEntry.
	paused := true.
	self midasFocus: anHistoryEntry value.
	paused := false.
	app refresh
]

{ #category : #history }
MidasContextHistory >> history [
	history
		ifNil: [ self initHistory ].
	^history
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
	self addToHistory: self midasFocus
]

{ #category : #initialization }
MidasContextHistory >> initialize [
	super initialize.
	paused := false.
	history := MidasHistory new.
]

{ #category : #history }
MidasContextHistory >> next [
	history hasNext ifFalse: [ ^ self ].
	self gotoEntry: history nextEntry.
]

{ #category : #notifications }
MidasContextHistory >> notifyMidasFocus: newFocus [
	paused ifTrue: [ ^ self ].
	self addToHistory: newFocus.
	app refresh
]

{ #category : #history }
MidasContextHistory >> prev [
	history hasPrevious
		ifFalse: [ ^ self ].
	self gotoEntry: history previousEntry.
]

{ #category : #notifications }
MidasContextHistory >> selected: anHistoryEntry [
	self gotoEntry: anHistoryEntry
]

{ #category : #history }
MidasContextHistory >> strongFocusFromHistory: newFocus [
	| cachedFrozen |
	cachedFrozen := frozen.
	frozen := true.
	self midasFocus: newFocus.
	frozen := cachedFrozen
]
