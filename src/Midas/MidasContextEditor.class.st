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
	self
		flag:
			'should test that the class or superclasses use FamixTWithSourceAnchor'.
	^ newFocus isKindOf: FamixStSourcedEntity 
]

{ #category : #notifications }
MidasContextEditor >> acceptWeakFocusUpdate: newFocus [
	^ self acceptStrongFocusUpdate: newFocus 
]
