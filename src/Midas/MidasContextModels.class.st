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
	#category : #'Midas-context'
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
	allModels := aCollection
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
	self mooseModel: (self allModels at: anIndex)
]
