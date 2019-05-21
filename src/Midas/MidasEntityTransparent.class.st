Class {
	#name : #MidasEntityTransparent,
	#superclass : #MidasEntityAbstract,
	#instVars : [
		'famix'
	],
	#category : #'Midas-context'
}

{ #category : #'instance creation' }
MidasEntityTransparent class >> with: anEntity [
	^self new
		famix: anEntity ;
		yourself
]

{ #category : #accessing }
MidasEntityTransparent >> displayWithParent: aBoolean [
	^ aBoolean
		ifFalse: [ famix name ]
		ifTrue: [ '** must implement #formatWithParent: **' ]
]

{ #category : #accessing }
MidasEntityTransparent >> famix: aFamixEntity [
	famix := aFamixEntity
]

{ #category : #formatting }
MidasEntityTransparent >> selection [
	^ famix
]
