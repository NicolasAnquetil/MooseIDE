Class {
	#name : #MidasContextSystemComplexity,
	#superclass : #MidasChildContext,
	#category : #'Midas-appModel'
}

{ #category : #notifications }
MidasContextSystemComplexity >> notifyMidasFocusFrozen: newFocus [
	app highlight: (newFocus entities)
]

{ #category : #notifications }
MidasContextSystemComplexity >> userSelection: selection [
	| wasFrozen nextGen |
	wasFrozen := self isFrozen.
	self freeze.
	nextGen := (self midasFocus entities includes: selection)
		ifTrue: [ self midasFocus nextGenerationFromSelect: [ :entity | entity = selection ] ]
		ifFalse: [ self midasFocus nextGenerationFromCollection: {(#unknown -> selection)} ].
	self midasFocus: nextGen.
	wasFrozen ifFalse: [ self unfreeze ]
]
