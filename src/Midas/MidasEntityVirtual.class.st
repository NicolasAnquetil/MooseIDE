Class {
	#name : #MidasEntityVirtual,
	#superclass : #MidasEntityAbstract,
	#instVars : [
		'name',
		'children'
	],
	#category : #'Midas-context'
}

{ #category : #'as yet unclassified' }
MidasEntityVirtual class >> with: aCollection named: aString [
	^self new
		children: aCollection ;
		name: aString ;
		yourself
]

{ #category : #initialization }
MidasEntityVirtual >> children: aCollection [
	children := aCollection 
]

{ #category : #formatting }
MidasEntityVirtual >> displayWithParent: aBoolean [
	^ aBoolean
		ifFalse: [ name ]
		ifTrue: [ '** must implement #formatWithParent: **' ]
]

{ #category : #initialization }
MidasEntityVirtual >> name: aString [
	name := aString
]

{ #category : #formatting }
MidasEntityVirtual >> selection [
	^children
]
