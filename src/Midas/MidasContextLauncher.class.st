"
Context for the launcher app. This is the root of the context hierarchy.
Contains the mooseModel we are working on and the entity-ies currently under focus 

Also implements an observer list: can register ""observers"" (called listeners) and will notify observers when it changes
"
Class {
	#name : #MidasContextLauncher,
	#superclass : #MidasAbstractContext,
	#instVars : [
		'mooseModel',
		'children'
	],
	#category : #'Midas-context'
}

{ #category : #accessing }
MidasContextLauncher >> addChild: aContext [
	(children includes: aContext)
		ifTrue: [ ^ self ].
	children add: aContext.
	aContext parentContext: self
]

{ #category : #initialization }
MidasContextLauncher >> initialize [
	super initialize.
	children := OrderedCollection new
]

{ #category : #accessing }
MidasContextLauncher >> mooseModel [
	^ mooseModel
]

{ #category : #accessing }
MidasContextLauncher >> mooseModel: newMooseModel [
	mooseModel = newMooseModel
		ifTrue: [ ^ self ].
	self resetFocuses.
	mooseModel := newMooseModel.
	self notifyModel: newMooseModel
]

{ #category : #notifications }
MidasContextLauncher >> notifyModel: newMooseModel [
	app updateModel: newMooseModel.
	children do: [ :child | child notifyModel: newMooseModel ]
]

{ #category : #notifications }
MidasContextLauncher >> notifyStrongFocus: newFocus [
	children do: [ :child | child notifyStrongFocus: newFocus]
]

{ #category : #notifications }
MidasContextLauncher >> notifyWeakFocus: newFocus [
	children do: [ :child | child notifyWeakFocus: newFocus ]
]

{ #category : #accessing }
MidasContextLauncher >> resetFocuses [
	self strongFocus: nil.
	self weakFocus: nil
]

{ #category : #'instance creation' }
MidasContextLauncher >> spawn: aContextClass [
	^aContextClass new
		parentContext: self ;
		yourself
]

{ #category : #accessing }
MidasContextLauncher >> strongFocus [
	^ focusStrong ifNil: [ self mooseModel ]
]

{ #category : #accessing }
MidasContextLauncher >> strongFocus: newFocus [
	focusStrong = newFocus
		ifTrue: [ ^ self ].
	focusStrong := newFocus.
	self notifyStrongFocus: newFocus
]

{ #category : #accessing }
MidasContextLauncher >> weakFocus [
	^focusWeak
]

{ #category : #accessing }
MidasContextLauncher >> weakFocus: newFocus [
	focusWeak = newFocus
		ifTrue: [ ^self ].
	focusWeak := newFocus.
	self notifyWeakFocus: newFocus
]
