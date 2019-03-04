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
