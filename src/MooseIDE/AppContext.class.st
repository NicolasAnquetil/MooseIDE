"
The execution context of an App.
Contains the entity on whih the app is executing, and the parent context of the calling app.

"
Class {
	#name : #AppContext,
	#superclass : #Object,
	#instVars : [
		'focus',
		'parentContext',
		'listeners'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #notifications }
AppContext >> addListener: aListener [
	listeners add: aListener
]

{ #category : #accessing }
AppContext >> focus [
	^ focus
]

{ #category : #accessing }
AppContext >> focus: anObject [
	focus := anObject
]

{ #category : #initialization }
AppContext >> initialize [
	listeners := OrderedCollection new
]

{ #category : #accessing }
AppContext >> mooseModel [
	^ parentContext mooseModel
]

{ #category : #accessing }
AppContext >> mooseModel: aMooseModel [
	parentContext mooseModel: aMooseModel
]

{ #category : #notifications }
AppContext >> notifyAll [
	listeners do: [ :l | l update: self ]
]

{ #category : #accessing }
AppContext >> parentContext [
	^ parentContext
]

{ #category : #accessing }
AppContext >> parentContext: anAppContext [
	parentContext := anAppContext
]

{ #category : #'as yet unclassified' }
AppContext >> spawn: aContextClass [
	| child |
	child := aContextClass new.
	child parentContext: self.
	^ child
]
