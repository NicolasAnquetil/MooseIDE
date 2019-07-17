Class {
	#name : #MidasContextNavigate,
	#superclass : #MidasChildContext,
	#category : #'Midas-context'
}

{ #category : #'as yet unclassified' }
MidasContextNavigate >> centralEntity [
	^ self weakFocus class
]

{ #category : #'as yet unclassified' }
MidasContextNavigate >> navigationProperties [
	^ (self weakFocus = self mooseModel)
			ifTrue: [ MidasFocusFormater new format: self mooseModel ]
			ifFalse: [(self mooseModel metamodel descriptionOf: self centralEntity) attributes
								select: [:p | p opposite isNotNil]]
]

{ #category : #accessing }
MidasContextNavigate >> selected: anObject [
	(anObject = self centralEntity)
		ifFalse: [ self strongFocus: (self weakFocus perform: anObject) ]
]
