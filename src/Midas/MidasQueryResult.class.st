Class {
	#name : #MidasQueryResult,
	#superclass : #Object,
	#instVars : [
		'entity',
		'parent'
	],
	#category : #'Midas-context'
}

{ #category : #'instance creation' }
MidasQueryResult class >> with: entity from: parent [
	^self new
		entity: entity ;
		parent: parent ;
		yourself
]

{ #category : #accessing }
MidasQueryResult >> entity [
	^ entity
]

{ #category : #accessing }
MidasQueryResult >> entity: anObject [
	entity := anObject
]

{ #category : #formatting }
MidasQueryResult >> formatWithParent: aBoolean [
	^ aBoolean
		ifFalse: [ entity name ]
		ifTrue: [ parent name , ' - ' , entity name ]
]

{ #category : #testing }
MidasQueryResult >> lessThan: other [
	^(parent = other parent)
			ifTrue: [ entity name <= other entity name ]
			ifFalse: [ parent name <= other parent name ]
		
]

{ #category : #accessing }
MidasQueryResult >> name [
	^ self entity name
]

{ #category : #accessing }
MidasQueryResult >> parent [
	^ parent
]

{ #category : #accessing }
MidasQueryResult >> parent: anObject [
	parent := anObject
]
