"
Context for AppTag
"
Class {
	#name : #MidasContextTag,
	#superclass : #MidasChildContext,
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextTag >> acceptModelUpdate: newModel [
	^ false
]

{ #category : #notifications }
MidasContextTag >> acceptWeakFocusUpdate: newFocus [
	^false
]
