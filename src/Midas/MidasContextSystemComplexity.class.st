Class {
	#name : #MidasContextSystemComplexity,
	#superclass : #MidasChildContext,
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextSystemComplexity >> acceptStrongFocusUpdate: newFocus [
	^ newFocus isCollection
]

{ #category : #notifications }
MidasContextSystemComplexity >> formatNewStrongFocus: newFocus [
	^self strongFocusIsModel
		ifTrue: [ self mooseModel allModelClasses ]
		ifFalse: [ newFocus ]
]
