"
The execution context of an App.
Contains the entity on whih the app is executing, and the parent context of the calling app.

"
Class {
	#name : #AppContext,
	#superclass : #Object,
	#instVars : [
		'currentGroup',
		'parent'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #accessing }
AppContext >> currentGroup [
	^ currentGroup ifNil: [ self model  ]
]

{ #category : #accessing }
AppContext >> currentGroup: aCollection [
	currentGroup := aCollection
]

{ #category : #accessing }
AppContext >> model [
	^ parent model
]

{ #category : #accessing }
AppContext >> parentContext [
	^ parent
]

{ #category : #accessing }
AppContext >> parentContext: anObject [
	parent := anObject
]
