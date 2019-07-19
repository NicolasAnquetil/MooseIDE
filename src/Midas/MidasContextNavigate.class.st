"
Context for the NavigateApp
Main reponsibilitity is to compute a list of properties that can be called on the entity-ies in focus.
Properties are the bi-directional association that link an entity to other ones
"
Class {
	#name : #MidasContextNavigate,
	#superclass : #MidasChildContext,
	#category : #'Midas-context'
}

{ #category : #'as yet unclassified' }
MidasContextNavigate >> centralEntity [
	^ self weakFocus class
]

{ #category : #visiting }
MidasContextNavigate >> doesNotUnderstand: message [
	((message selector asString beginsWith: 'visit') and: [message arguments size = 1])
		ifFalse: [ "does not seem to be a visitFAMIXClass: message so really does not understand"
			^ super doesNotUnderstand: message ].

	^self navigationPropertiesForClass: message argument class
]

{ #category : #'as yet unclassified' }
MidasContextNavigate >> navigationProperties [
	(self weakFocus = self mooseModel)
		ifTrue: [ ^ self navigationPropertiesForModel: self weakFocus ].
	self weakFocus isCollection
		ifTrue: [ ^ self navigationPropertiesForCollection: self weakFocus ].
	^ self navigationPropertiesForClass: self weakFocus class
]

{ #category : #'as yet unclassified' }
MidasContextNavigate >> navigationPropertiesForClass: aClass [
	^ (self mooseModel metamodel descriptionOf: aClass) allAttributes
			select: [:p | p opposite isNotNil]
]

{ #category : #visiting }
MidasContextNavigate >> navigationPropertiesForCollection: aCollectionOfEntities [
	| classes props |
	classes := (aCollectionOfEntities groupedBy: #class) keys.
	props := self navigationPropertiesForClass: classes first.
	classes allButFirstDo: [ :cl |
		props := props intersection: (self navigationPropertiesForClass: cl) ].
	^ props
]

{ #category : #visiting }
MidasContextNavigate >> navigationPropertiesForModel: aMooseModel [
	^ MidasFocusFormater new format: aMooseModel
]

{ #category : #accessing }
MidasContextNavigate >> selected: anObject [
	(anObject = self centralEntity)
		ifFalse: [ self strongFocus: (self weakFocus perform: anObject methodSelector) ]
]
