Class {
	#name : #FAMIXTag,
	#superclass : #MooseEntity,
	#instVars : [
		'entities',
		'name',
		'color'
	],
	#classInstVars : [
		'allTags'
	],
	#category : #FamixTags
}

{ #category : #'instance creation' }
FAMIXTag class >> named: aString [
	^allTags
		detect: [ :o | o name = aString ]
		ifNone: [ |tag|
			tag := self new.
			tag name: aString.
			allTags add: tag.
			tag]
		
]

{ #category : #initialization }
FAMIXTag class >> reset [
	allTags := OrderedCollection new
]

{ #category : #accessing }
FAMIXTag >> color [
	^color
]

{ #category : #accessing }
FAMIXTag >> color: aColor [
	color := aColor
]

{ #category : #accessing }
FAMIXTag >> entities [
	^ entities
]

{ #category : #accessing }
FAMIXTag >> entities: anObject [
	entities := anObject
]

{ #category : #initialization }
FAMIXTag >> initialize [
	super initialize.
	entities := OrderedCollection new.
	color := Color random
]

{ #category : #accessing }
FAMIXTag >> name [
	^ name
]

{ #category : #accessing }
FAMIXTag >> name: anObject [
	name := anObject
]

{ #category : #accessing }
FAMIXTag >> unsafeAddEntity: anObject [
	entities add: anObject
]

{ #category : #accessing }
FAMIXTag >> unsafeRemoveEntity: anObject [
	entities remove: anObject
]
