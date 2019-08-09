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

{ #category : #accessing }
MidasContextNavigate >> doesNotUnderstand: message [
	((message selector asString beginsWith: 'visit') and: [message arguments size = 1])
		ifFalse: [ "does not seem to be a visitFAMIXClass: message so really does not understand"
			^ super doesNotUnderstand: message ].

	^self navigationPropertiesForClass: message argument class
]

{ #category : #accessing }
MidasContextNavigate >> navigationProperties [
	self focusIsMooseModel
		ifTrue: [ ^ self navigationPropertiesForModel: self midasFocus ].
	self midasFocus isCollection
		ifTrue: [ ^ self navigationPropertiesForCollection: self midasFocus ].
	^ self navigationPropertiesForClass: self midasFocus class
]

{ #category : #accessing }
MidasContextNavigate >> navigationPropertiesForClass: aClass [
	^ (self mooseModel metamodel descriptionOf: aClass) allAttributes
			select: [:p | p opposite isNotNil]
]

{ #category : #accessing }
MidasContextNavigate >> navigationPropertiesForCollection: aCollectionOfEntities [
	| classes props |
	classes := (aCollectionOfEntities groupedBy: #class) keys.
	props := self navigationPropertiesForClass: classes first.
	classes allButFirstDo: [ :cl |
		props := props intersection: (self navigationPropertiesForClass: cl) ].
	^ props
]

{ #category : #accessing }
MidasContextNavigate >> navigationPropertiesForModel: aMooseModel [
	^ aMooseModel navigationSelectors collect: [ :sel |
			MidasEntityNavigateModel new
				selector: sel ;
				name: sel ;
				yourself
		]
]

{ #category : #accessing }
MidasContextNavigate >> selected: anObject [
	| focus |
	focus := self midasFocus.
	(self focusIsMooseModel: focus)
		ifTrue: [ ^ self midasFocus: (focus perform: anObject methodSelector) ].
	focus isCollection
		ifTrue: [ ^ self midasFocus: (focus flatCollect: [ :each | each perform: anObject methodSelector]) ].
	self midasFocus: (focus perform: anObject methodSelector)
	
]
