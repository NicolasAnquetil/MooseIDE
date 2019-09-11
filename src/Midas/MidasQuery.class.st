"
Abstract class of a query that selects some entities from a context

Selectors:

entities -- the selected entities
displayName
model: -- sets the model containing all entities from which to select
"
Class {
	#name : #MidasQuery,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'Midas-helpers'
}

{ #category : #accessing }
MidasQuery >> displayName [
	^ self class displayName
]

{ #category : #accessing }
MidasQuery >> entities [
	self subclassResponsibility 
]

{ #category : #accessing }
MidasQuery >> master: aGuiModel [
	context := aGuiModel 
]
