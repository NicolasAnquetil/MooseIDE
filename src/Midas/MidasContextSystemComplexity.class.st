Class {
	#name : #MidasContextSystemComplexity,
	#superclass : #MidasChildContext,
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextSystemComplexity >> acceptMidasFocusUpdate: newFocus [
	^ newFocus isCollection
]

{ #category : #notifications }
MidasContextSystemComplexity >> formatMidasFocus: newFocus [
	^self midasFocusIsModel
		ifTrue: [ self mooseModel allModelClasses ]
		ifFalse: [ newFocus ]
]
