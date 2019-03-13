"
Context for the source code ""editor"".
Does not really edit, just show the code
"
Class {
	#name : #MidasContextEditor,
	#superclass : #MidasChildContext,
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextEditor >> acceptStrongFocusUpdate: newFocus [
	^ newFocus isKindOf: FAMIXSourcedEntity 
]

{ #category : #notifications }
MidasContextEditor >> acceptWeakFocusUpdate: newFocus [
	^ self acceptStrongFocusUpdate: newFocus 
]
