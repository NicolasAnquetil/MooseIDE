Class {
	#name : #MidasContextSystemComplexity,
	#superclass : #MidasChildContext,
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextSystemComplexity >> acceptStrongFocus: newFocus [
	^ newFocus isCollection
]
