"
Models a selector on a moose model usable by MidasQuery

Mimicks a FM3PropertyDescription
"
Class {
	#name : #MidasFM3PropertyForModels,
	#superclass : #Object,
	#instVars : [
		'selector',
		'name'
	],
	#category : #'Midas-focusModel'
}

{ #category : #accessing }
MidasFM3PropertyForModels >> isMultivalued [
	"assuming all properties for a MooseModel return a collection of entities"
	^true
]

{ #category : #accessing }
MidasFM3PropertyForModels >> methodSelector [
	^ selector
]

{ #category : #accessing }
MidasFM3PropertyForModels >> name [
	^ name
]

{ #category : #accessing }
MidasFM3PropertyForModels >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MidasFM3PropertyForModels >> selector [
	^ selector
]

{ #category : #accessing }
MidasFM3PropertyForModels >> selector: anObject [
	selector := anObject
]
