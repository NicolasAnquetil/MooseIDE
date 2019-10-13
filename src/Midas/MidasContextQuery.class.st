Class {
	#name : #MidasContextQuery,
	#superclass : #MidasChildContext,
	#instVars : [
		'queryIsfilter'
	],
	#category : #'Midas-appModel'
}

{ #category : #private }
MidasContextQuery >> compileStringToBlock: aStringQuery [
	^ OpalCompiler new
		source: ('[:each |' , aStringQuery , ']') ;
		logged: false;
		evaluate
]

{ #category : #initialization }
MidasContextQuery >> initialize [
	super initialize.
	queryIsfilter := true
]

{ #category : #running }
MidasContextQuery >> interpretQuery: aBlockAsString [
	| aBlock |
	aBlockAsString
		ifEmpty: [ ^ self "notifyMidasFocus: history now" ].
	aBlock :=self compileStringToBlock: aBlockAsString.
	self
		midasFocus:
			(self queryIsFilter
				ifTrue: [ self midasFocus selectNextGeneration: aBlock ]
				ifFalse: [ self midasFocus collectNextGeneration: aBlock ])
]

{ #category : #running }
MidasContextQuery >> navigationProperties [
	self midasFocus isEmpty
		ifTrue: [ ^ #() ].
	self midasFocus isModel
		ifTrue: [ ^ self navigationPropertiesForModel: self midasFocus ].
	^ self navigationPropertiesForCollection: self midasFocus entities
]

{ #category : #running }
MidasContextQuery >> navigationPropertiesForClass: aClass [
	^ (self mooseModel metamodel descriptionOf: aClass) allAttributes
			select: [:p | p opposite isNotNil]
]

{ #category : #running }
MidasContextQuery >> navigationPropertiesForCollection: aCollectionOfEntities [
	| classes props |
	classes := (aCollectionOfEntities groupedBy: #class) keys.
	props := self navigationPropertiesForClass: classes first.
	classes allButFirstDo: [ :cl |
		props := props intersection: (self navigationPropertiesForClass: cl) ].
	^ props
]

{ #category : #running }
MidasContextQuery >> navigationPropertiesForModel: aMooseModel [
	^ aMooseModel navigationSelectors collect: [ :sel |
			MidasEntityNavigateModel new
				selector: sel ;
				name: sel ;
				yourself
		]
]

{ #category : #accessing }
MidasContextQuery >> queryIsFilter [
	^ queryIsfilter
]

{ #category : #accessing }
MidasContextQuery >> queryIsFilter: aBoolean [
	queryIsfilter := aBoolean 
]

{ #category : #notifications }
MidasContextQuery >> userSelection: anObject [
	| focus |
	focus := self midasFocus.
	(focus isModel)
		ifTrue: [ ^ self midasFocus: (focus nextGenerationSelector: anObject methodSelector) ].
	self midasFocus: (focus nextGenerationSelector: anObject methodSelector)
	
]
