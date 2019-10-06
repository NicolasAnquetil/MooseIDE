"
Context for EntitiesApp
"
Class {
	#name : #MidasContextEntities,
	#superclass : #MidasChildContext,
	#instVars : [
		'listEntities'
	],
	#category : #'Midas-appModel'
}

{ #category : #running }
MidasContextEntities >> entitiesToSelection: focus [
	focus ifEmpty: [ ^ self ].
	^ hierarchicalFocus
			ifTrue: [ self midasFocus selectPathsIndexed: focus ]
			ifFalse: [ self midasFocus selectEntitiesIndexed: focus flatten ]
]

{ #category : #running }
MidasContextEntities >> focusOnSelection: selectedIndexes [
	"forces receiver to focus on the selection, whatever the states of the flags frozen and selectionFrozen"
	| wasFrozen |
	wasFrozen := frozen.
	frozen := false.
	self notifyMidasFocus: self midasFocus.
	frozen := wasFrozen.
]

{ #category : #notifications }
MidasContextEntities >> formatMidasFocus: newFocus [
	^hierarchicalFocus
		ifTrue:  [ newFocus ancestors ]
		ifFalse: [ newFocus entities ]
		
]

{ #category : #notifications }
MidasContextEntities >> formatedMidasFocus [
	^ self formatMidasFocus: self midasFocus
]

{ #category : #running }
MidasContextEntities >> selectionToEntities: paths [
	^ hierarchicalFocus
			ifTrue: [ self midasFocus selectPathsIndexed: paths ]
			ifFalse: [ self midasFocus selectEntitiesIndexed: paths flatten ]
]

{ #category : #running }
MidasContextEntities >> userSelection: selectedPaths [
	selectedPaths ifEmpty: [ ^ self ].
	self midasFocus: (self selectionToEntities: selectedPaths)
]
