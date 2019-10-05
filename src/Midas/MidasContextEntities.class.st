"
Context for EntitiesApp
"
Class {
	#name : #MidasContextEntities,
	#superclass : #MidasChildContext,
	#instVars : [
		'resultsWithParents',
		'listEntities',
		'frozenFocus'
	],
	#category : #'Midas-appModel'
}

{ #category : #notifications }
MidasContextEntities >> childrenFor: aRoot [
	^resultsWithParents
		ifTrue:  [ self midasFocus childrenFor: aRoot ]
		ifFalse: [ #() ]
		
]

{ #category : #running }
MidasContextEntities >> entitiesToSelection: focus [
	focus ifEmpty: [ ^ self ].
	^ resultsWithParents
			ifTrue: [ self midasFocus selectPathsIndexed: focus ]
			ifFalse: [ self midasFocus selectEntitiesIndexed: focus flatten ]
]

{ #category : #accessing }
MidasContextEntities >> flattenResult [
	resultsWithParents := false.
	self notifyMidasFocus: self midasFocus
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
	^resultsWithParents
		ifTrue:  [ newFocus ancestors ]
		ifFalse: [ newFocus entities ]
		
]

{ #category : #notifications }
MidasContextEntities >> formatedMidasFocus [
	^ self formatMidasFocus: self midasFocus
]

{ #category : #accessing }
MidasContextEntities >> freeze [ 
	super freeze.
	frozenFocus := self midasFocus
]

{ #category : #initialization }
MidasContextEntities >> initialize [
	super initialize.
	resultsWithParents := false
]

{ #category : #accessing }
MidasContextEntities >> resultsWithParents [
	^resultsWithParents
]

{ #category : #running }
MidasContextEntities >> selectionToEntities: paths [
	^ resultsWithParents
			ifTrue: [ self midasFocus selectPathsIndexed: paths ]
			ifFalse: [ self midasFocus selectEntitiesIndexed: paths flatten ]
]

{ #category : #accessing }
MidasContextEntities >> trackAssociation [
	resultsWithParents := true.
	self notifyMidasFocus: self midasFocus
]

{ #category : #running }
MidasContextEntities >> userSelection: selectedPaths [
	selectedPaths ifEmpty: [ ^ self ].
	self midasFocus: (self selectionToEntities: selectedPaths)
]
