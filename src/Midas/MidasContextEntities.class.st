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

{ #category : #notifications }
MidasContextEntities >> formatMidasFocus: newFocus [
	^hierarchicalFocus
		ifTrue:  [ newFocus ancestors ]
		ifFalse: [ newFocus entities ]

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
			ifTrue: [ self midasFocus selectPathsIndexed: paths ]
			ifFalse: [ self midasFocus selectEntitiesIndexed: paths flatten ]
]

{ #category : #running }
MidasContextEntities >> userSelection: selectedPaths [
	selectedPaths ifEmpty: [ ^ self ].
	self midasFocus: (self selectionToEntities: selectedPaths)
]
