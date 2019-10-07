Class {
	#name : #MidasContextSystemComplexity,
	#superclass : #MidasChildContext,
	#category : #'Midas-appModel'
}

{ #category : #accessing }
MidasContextSystemComplexity >> entities [
	^ self midasFocus entities
]

{ #category : #notifications }
MidasContextSystemComplexity >> notifyMidasFocusFrozen: newFocus [
	app highlight: (newFocus entities)
]
