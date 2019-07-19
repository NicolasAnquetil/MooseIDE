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
	| selector |
	selector := message selector asString.
	((selector beginsWith: 'visit') and: [ (selector count: [ :c | c = $: ]) = 1 ])
		ifFalse: [ "does not seem to be a visitFAMIXClass: message"
			^ super doesNotUnderstand: message ].
	
]

{ #category : #'as yet unclassified' }
MidasContextNavigate >> navigationProperties [
	^ self weakFocus accept: self
]

{ #category : #'as yet unclassified' }
MidasContextNavigate >> navigationPropertiesForClass: aClass [
	^ (aClass = MooseModel)
			ifTrue: [ self navigationPropertiesForMooseModel ]
			ifFalse: [(self mooseModel metamodel descriptionOf: aClass) allAttributes
								select: [:p | p opposite isNotNil]]
]

{ #category : #'as yet unclassified' }
MidasContextNavigate >> navigationPropertiesForCollection [
	| classes props |
	classes := (self weakFocus groupedBy: #class) keys.
	props := self navigationPropertiesForClass: classes first.
	classes allButFirstDo: [ :cl |
		props := props intersection: (self navigationPropertiesForClass: cl) ].
	^ props
]

{ #category : #'as yet unclassified' }
MidasContextNavigate >> navigationPropertiesForMooseModel [
	^ self mooseModel entityCache
		associationsDo: [ :assoc || label |
			label := assoc key asString.
			(label beginsWith: 'All model')
			ifTrue: [	self virtualEntity: label from: assoc value]
		]
]

{ #category : #accessing }
MidasContextNavigate >> selected: anObject [
	(anObject = self centralEntity)
		ifFalse: [ self strongFocus: (self weakFocus perform: anObject methodSelector) ]
]

{ #category : #visiting }
MidasContextNavigate >> visitCollection: aCollectionOfEntities [
	| classes props |
	classes := (aCollectionOfEntities groupedBy: #class) keys.
	props := self navigationPropertiesForClass: classes first.
	classes allButFirstDo: [ :cl |
		props := props intersection: (self navigationPropertiesForClass: cl) ].
	^ props
]

{ #category : #visiting }
MidasContextNavigate >> visitModel: aMooseModel [
	^ MidasFocusFormater new format: aMooseModel
]
