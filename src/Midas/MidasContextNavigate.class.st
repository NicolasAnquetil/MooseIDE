"
Context for the NavigateApp
Main reponsibilitity is to compute a list of properties that can be called on the entity-ies in focus.
Properties are the bi-directional association that link an entity to other ones
"
Class {
	#name : #MidasContextNavigate,
	#superclass : #MidasChildContext,
	#category : #'Midas-appModel'
}

{ #category : #running }
MidasContextNavigate >> doesNotUnderstand: message [
	"capturing #visitXXX: message and redirecting to FAMIXClass"
	((message selector asString beginsWith: 'visit') and: [message arguments size = 1])
		ifFalse: [ "does not seem to be a #visitFAMIXClass: message, so really does not understand"
			^ super doesNotUnderstand: message ].

	^self navigationPropertiesForClass: message argument class
]

{ #category : #running }
MidasContextNavigate >> navigationProperties [
	self midasFocus isEmpty
		ifTrue: [ ^ #() ].
	self midasFocus isModel
		ifTrue: [ ^ self navigationPropertiesForModel: self midasFocus ].
	^ self navigationPropertiesForCollection: self midasFocus entities
]

{ #category : #running }
MidasContextNavigate >> navigationPropertiesForClass: aClass [
	^ (self mooseModel metamodel descriptionOf: aClass) allAttributes
			select: [:p | p opposite isNotNil]
]

{ #category : #running }
MidasContextNavigate >> navigationPropertiesForCollection: aCollectionOfEntities [
	| classes props |
	classes := (aCollectionOfEntities groupedBy: #class) keys.
	props := self navigationPropertiesForClass: classes first.
	classes allButFirstDo: [ :cl |
		props := props intersection: (self navigationPropertiesForClass: cl) ].
	^ props
]

{ #category : #running }
MidasContextNavigate >> navigationPropertiesForModel: aMooseModel [
	^ aMooseModel navigationSelectors collect: [ :sel |
			MidasEntityNavigateModel new
				selector: sel ;
				name: sel ;
				yourself
		]
]

{ #category : #notifications }
MidasContextNavigate >> userSelection: anObject [
	| focus |
	focus := self midasFocus.
	(focus isModel)
		ifTrue: [ ^ self midasFocus: (focus nextGenerationSelector: anObject methodSelector) ].
	focus isCollection
		ifTrue: [ ^ self midasFocus: (focus flatCollect: [ :each | each nextGenerationSelector: anObject methodSelector]) ].
	self midasFocus: (focus nextGenerationSelector: anObject methodSelector)
	
]
