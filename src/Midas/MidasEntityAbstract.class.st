"
I represent a (presumably) Famix entity (or list of entities) inside Midas.
I also handle the notion of a 'parent entity', the one from which this entity was derived through some query

I unify treatment for all possibilities (mooseModel, famix entity, collection of entities)

Messages
- displayString, how to represent the inner entity (or list of)
- entities, the list of entities contained (possibly only one)
- parentEntity, the entiy from which this entity was derived through a query
"
Class {
	#name : #MidasEntityAbstract,
	#superclass : #Object,
	#category : #'Midas-context'
}

{ #category : #formatting }
MidasEntityAbstract >> displayString [
	self subclassResponsibility
]

{ #category : #formatting }
MidasEntityAbstract >> entities [
	self subclassResponsibility
]

{ #category : #testing }
MidasEntityAbstract >> isModel [
	^ false
]

{ #category : #testing }
MidasEntityAbstract >> sameModel: aModel [
	^ false
]
