"
Context for AppMetrics
Overrides various methods
"
Class {
	#name : #MidasContextModels,
	#superclass : #MidasChildContext,
	#instVars : [
		'allModels'
	],
	#category : #'Midas-appModel'
}

{ #category : #notifications }
MidasContextModels >> acceptMidasFocusUpdate: newFocus [
	^ false
]

{ #category : #accessing }
MidasContextModels >> allModels [
	^ allModels
]

{ #category : #accessing }
MidasContextModels >> allModels: aCollection [ 
	allModels := aCollection.
	app ifNotNil: [ app refresh ]
]

{ #category : #initialization }
MidasContextModels >> initialize [
	super initialize.
	allModels := MooseModel root allModels
]

{ #category : #accessing }
MidasContextModels >> mooseModel: newMooseModel [
	parentContext mooseModel: newMooseModel

]

{ #category : #notifications }
MidasContextModels >> userSelection: anIndex [
	| newMooseModel |
	((anIndex < 1) or: [ anIndex > self allModels size ])
		ifTrue: [  ^ self ].
	newMooseModel := (self allModels at: anIndex).
	(self mooseModel notNil and: [self mooseModel sameModel: newMooseModel])
		ifTrue: [ ^ self ].
	self mooseModel: (MidasEntityMooseModel with: newMooseModel)

]
