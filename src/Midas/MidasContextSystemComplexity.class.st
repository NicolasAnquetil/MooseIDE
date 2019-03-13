Class {
	#name : #MidasContextSystemComplexity,
	#superclass : #MidasChildContext,
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextSystemComplexity >> acceptStrongFocusUpdate: newFocus [
	^ newFocus isCollection
]
