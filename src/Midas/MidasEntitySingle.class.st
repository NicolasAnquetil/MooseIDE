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

{ #category : #indexing }
MidasEntitySingle >> pathsFor: midasEntities [
	| paths |
	paths := OrderedCollection new: 2.
	
	(midasEntities entities includes: ancestor)
		ifTrue: [ paths add: #(1) ].
	(midasEntities entities includes: singleEntity)
		ifTrue: [ paths add: #(1 1) ].
	^ paths
]

{ #category : #indexing }
MidasEntitySingle >> selectEntitiesFromIndexes: indexes [
	^ (indexes includes: 1)
			ifTrue: self
			ifFalse: [ MidasEntityEmpty ancestor: singleEntity ]
]

{ #category : #indexing }
MidasEntitySingle >> selectEntitiesFromPaths: paths [
	^( (paths includes: #(1)) or: [ paths includes: #(1 1) ] )
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
