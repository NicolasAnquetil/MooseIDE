"
Context for the launcher app. This is the root of the context hierarchy.
Contains the mooseModel we are working on and the entity-ies currently under focus 

Also implements an observer list: can register ""observers"" (called listeners) and will notify observers when it changes
"
Class {
	#name : #AppContextLauncher,
	#superclass : #AppContext,
	#instVars : [
		'mooseModel'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #notifications }
AppContextLauncher >> addListener: aListener [
	listeners add: aListener
]

{ #category : #accessing }
AppContextLauncher >> focus [
	^ focus ifNil: [ self mooseModel  ]
]

{ #category : #accessing }
AppContextLauncher >> focus: anObject [
	focus := anObject.
	self notifyAll
]

{ #category : #initialization }
AppContextLauncher >> initialize [
	super initialize.
	self resetListners
]

{ #category : #accessing }
AppContextLauncher >> mooseModel [
	^ mooseModel
]

{ #category : #accessing }
AppContextLauncher >> mooseModel: anObject [
	mooseModel := anObject
]

{ #category : #notifications }
AppContextLauncher >> notifyAll [
	listeners do: [ :l | l update: self ]
]

{ #category : #notifications }
AppContextLauncher >> resetListners [
	listeners := OrderedCollection new
]
