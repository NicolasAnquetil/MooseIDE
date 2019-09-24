Class {
	#name : #MidasEntitiesModel,
	#superclass : #Object,
	#instVars : [
		'root',
		'children'
	],
	#category : #'Midas-focusModel'
}

{ #category : #'instance creation' }
MidasEntitiesModel class >> root: anEntity children: aCollection [
	^ self new
		root: anEntity ;
		children: aCollection ;
		yourself
]

{ #category : #accessing }
MidasEntitiesModel >> children [
	^ children
]

{ #category : #accessing }
MidasEntitiesModel >> children: anObject [
	children := anObject
]

{ #category : #accessing }
MidasEntitiesModel >> root [
	^ root
]

{ #category : #accessing }
MidasEntitiesModel >> root: anObject [
	root := anObject
]
