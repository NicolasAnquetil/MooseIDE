"
The execution context of an App.
Contains the entity on whih the app is executing, and the parent context of the calling app.

"
Class {
	#name : #AppContext,
	#superclass : #Object,
	#instVars : [
		'focus',
		'frozen',
		'parentContext',
		'listeners'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #notifications }
AppContext >> addListener: aListener [
	parentContext addListener: aListener
]

{ #category : #accessing }
AppContext >> focus [
	^frozen
		ifTrue: [ focus ]
		ifFalse: [  parentContext  focus ]
]

{ #category : #accessing }
AppContext >> focus: anObject [
	frozen
		ifTrue: [ focus := anObject ]
		ifFalse: [  parentContext  focus: anObject ].
]

{ #category : #accessing }
AppContext >> freeze [
	focus := self focus.
	frozen := true.
]

{ #category : #initialization }
AppContext >> initialize [
	frozen := false.
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
	parentContext notifyAll
]

{ #category : #accessing }
AppContext >> parentContext [
	^ parentContext
]

{ #category : #accessing }
AppContext >> parentContext: anAppContext [
	parentContext := anAppContext
]

{ #category : #'instance creation' }
AppContext >> spawn: aContextClass [
	| child |
	child := aContextClass new.
	child parentContext: self.
	^ child
]

{ #category : #accessing }
AppContext >> unfreeze [
	frozen := false.
]
