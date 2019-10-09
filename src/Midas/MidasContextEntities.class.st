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
			ifTrue: [ self midasFocus selectEntitiesFromPaths: focus ]
			ifFalse: [ self midasFocus selectEntitiesFromIndexes: focus flatten ]
]

{ #category : #notifications }
MidasContextEntities >> formatMidasFocus: newFocus [
	^self roots: newFocus

]

{ #category : #notifications }
MidasContextEntities >> formatNewModel: newModel [
	^newModel entities
]

{ #category : #notifications }
MidasContextEntities >> formatedMidasFocus [
	^ self formatMidasFocus: self midasFocus
]

{ #category : #notifications }
MidasContextEntities >> notifyMidasFocusFrozen: newFocus [
	| selectedPaths |
	selectedPaths := myFocusFrozen pathsFor: newFocus.
	selectedPaths ifEmpty: [ ^ self ].
	self focusIsHierarchical
		ifTrue: [ app selectPaths: selectedPaths ]
		ifFalse: [ app selectPaths: (selectedPaths collect: [ :path | {path second} ] ) ]
]

{ #category : #running }
MidasContextEntities >> selectionToEntities: paths [
	^ hierarchicalFocus
			ifTrue: [ self midasFocus selectEntitiesFromPaths: paths ]
			ifFalse: [ self midasFocus selectEntitiesFromIndexes: paths flatten ]
]

{ #category : #running }
MidasContextEntities >> userSelection: selectedPaths [
	| wasFrozen |
	selectedPaths ifEmpty: [ ^ self ].

	wasFrozen := self isFrozen.
	self freeze.
	self midasFocus: (self selectionToEntities: selectedPaths).
	wasFrozen ifFalse: [ self unfreeze ]
]
