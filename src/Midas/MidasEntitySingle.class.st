"
I am a MidasEntity with exactly one inner entity

When I don't understand something, I pass it through to my inner entity to see if it can handle it for me

"
Class {
	#name : #MidasEntitySingle,
	#superclass : #MidasEntityAbstract,
	#instVars : [
		'singleEntity'
	],
	#category : #'Midas-focusModel'
}

{ #category : #'instance creation' }
MidasEntitySingle class >> with: anEntity ancestor: aMidasEntity [
	^ self new
			singleEntity: anEntity ;
			ancestor: aMidasEntity ;
			yourself
]

{ #category : #'reflective operations' }
MidasEntitySingle >> doesNotUnderstand: aMessage [
	^ [ aMessage sendTo: singleEntity ]
		on: MessageNotUnderstood
		do: [ super doesNotUnderstand: aMessage ]
]

{ #category : #formatting }
MidasEntitySingle >> entities [
	^ { singleEntity }
]

{ #category : #accessing }
MidasEntitySingle >> entitiesWithAncestors [
	^ { ancestor -> { singleEntity } }
]

{ #category : #private }
MidasEntitySingle >> indexInListWithoutAncestors: index [
	"Index considers a list including the ancestor, we translate it to an index in the list of entities
	i.e.  '1' tranlates to nothing and '2' translates to '1'"
	^ index = 2
		ifTrue: [ 1 ]
		ifFalse: [ 0 ]
]

{ #category : #private }
MidasEntitySingle >> selectEntitiesIndexed: indexes [
	^ (indexes includes: 1)
			ifTrue: self
			ifFalse: [ MidasEntityEmpty ancestor: singleEntity ]
]

{ #category : #accessing }
MidasEntitySingle >> singleEntity [
	^ singleEntity 
]

{ #category : #accessing }
MidasEntitySingle >> singleEntity: aFamixEntity [
	singleEntity := aFamixEntity
]

{ #category : #accessing }
MidasEntitySingle >> size [
	"optimization"
	^1
]
