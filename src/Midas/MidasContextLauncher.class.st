"
Context for the launcher app. This is the root of the context hierarchy.
Contains the mooseModel we are working on and the entity-ies currently under focus 

Also implements an observer list: can register ""observers"" (called listeners) and will notify observers when it changes
"
Class {
	#name : #MidasContextLauncher,
	#superclass : #MidasContext,
	#instVars : [
		'mooseModel'
	],
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextLauncher >> addListener: aListener [
	listeners add: aListener
]

{ #category : #accessing }
MidasContextLauncher >> focus [
	^ focus ifNil: [ self mooseModel  ]
]

{ #category : #accessing }
MidasContextLauncher >> focus: anObject [
	focus := anObject.
	self notifyAll
]

{ #category : #initialization }
MidasContextLauncher >> initialize [
	super initialize.
	self resetListners
]

{ #category : #accessing }
MidasContextLauncher >> mooseModel [
	^ mooseModel
]

{ #category : #accessing }
MidasContextLauncher >> mooseModel: anObject [
	mooseModel := anObject
]

{ #category : #notifications }
MidasContextLauncher >> notifyAll [
	listeners do: [ :l | l update: self ]
]

{ #category : #notifications }
MidasContextLauncher >> resetListners [
	listeners := OrderedCollection new
]
