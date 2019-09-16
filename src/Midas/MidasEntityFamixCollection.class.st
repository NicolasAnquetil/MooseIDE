"
I am a MidasEntity containing alist of Famix entities

"
Class {
	#name : #MidasEntityFamixCollection,
	#superclass : #MidasEntityAbstract,
	#instVars : [
		'name',
		'entities'
	],
	#category : #'Midas-context'
}

{ #category : #'as yet unclassified' }
MidasEntityFamixCollection class >> with: aCollection [
	^self with: aCollection named: (aCollection size , ' entities')
]

{ #category : #'as yet unclassified' }
MidasEntityFamixCollection class >> with: aCollection named: aString [
	^self new
		entities: aCollection ;
		name: aString ;
		yourself
]

{ #category : #formatting }
MidasEntityFamixCollection >> displayString [
	^ self name
]

{ #category : #formatting }
MidasEntityFamixCollection >> entities [
	^entities
]

{ #category : #initialization }
MidasEntityFamixCollection >> entities: aCollection [
	entities := aCollection 
]

{ #category : #initialization }
MidasEntityFamixCollection >> name [
	^ name
]

{ #category : #initialization }
MidasEntityFamixCollection >> name: aString [
	name := aString
]
