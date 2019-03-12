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
MidasContextLauncher >> notifyAllStrong [
	listeners do: [ :l | l updateStrong: self strongFocus ]
]

{ #category : #notifications }
MidasContextLauncher >> notifyAllWeak [
	listeners do: [ :l | l updateWeak: self weakFocus ]
]

{ #category : #notifications }
MidasContextLauncher >> resetListners [
	listeners := OrderedCollection new
]

{ #category : #accessing }
MidasContextLauncher >> strongFocus [
	^ focusStrong ifNil: [ self mooseModel ]
]

{ #category : #accessing }
MidasContextLauncher >> strongFocus: anObject [
	focusStrong := anObject.
	self notifyAllStrong
]

{ #category : #accessing }
MidasContextLauncher >> weakFocus [
	^ focusWeak
]

{ #category : #accessing }
MidasContextLauncher >> weakFocus: anObject [
	focusWeak := anObject.
	self notifyAllWeak
]
