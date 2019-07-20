Class {
	#name : #MidasContextHistory,
	#superclass : #MidasChildContext,
	#instVars : [
		'history'
	],
	#category : #'Midas-context'
}

{ #category : #history }
MidasContextHistory >> addToHistory: anEntry [
	history add: anEntry.
	app updatePreviousNext 
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
	history := MidasHistory new
]

{ #category : #history }
MidasContextHistory >> next [
	history hasNext
		ifTrue: [ self strongFocusFromHistory: history next.
			app updatePreviousNext ]
]

{ #category : #history }
MidasContextHistory >> prev [
	history hasPrevious
		ifTrue: [ self strongFocusFromHistory: history previous.
			app updatePreviousNext ]
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