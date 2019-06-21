"
Context for the launcher app. This is the root of the context hierarchy.
Contains the mooseModel we are working on and the entity-ies currently under focus 

Also implements an observer list: can register ""observers"" (called listeners) and will notify observers when it changes
"
Class {
	#name : #MidasContextLauncher,
	#superclass : #MidasAbstractContext,
	#instVars : [
		'children',
		'focusWeak',
		'mooseModel'
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

{ #category : #actions }
MidasContextLauncher >> exit [
	children
		do: [ :child | 
			child exit ].
	children removeAll.
	app delete.
	app := nil
]

{ #category : #initialization }
MidasContextLauncher >> initialize [
	super initialize.
	children := OrderedCollection new.
]

{ #category : #accessing }
MidasContextLauncher >> mooseModel [
	^ mooseModel
]

{ #category : #accessing }
MidasContextLauncher >> mooseModel: newMooseModel [
	newMooseModel ifNil: [ ^ self ].
	mooseModel = newMooseModel
		ifTrue: [ ^ self ].
	self notifyNewModel: newMooseModel
]

{ #category : #accessing }
MidasContextLauncher >> mooseModelAsGroups [
	^ self mooseModel ifNotNil: [ :model | model entityCache associationsSelect: [ :a | a key isString and: [a key beginsWith: 'All model']]]
]

{ #category : #notifications }
MidasContextLauncher >> notifyNewModel: newMooseModel [
	app updateModel: newMooseModel.
	children do: [ :child | child notifyNewModel: newMooseModel ]
]

{ #category : #notifications }
MidasContextLauncher >> notifyStrongFocus: newFocus [
	children do: [ :child | child notifyStrongFocus: newFocus]
]

{ #category : #notifications }
MidasContextLauncher >> notifyWeakFocus: newFocus [
	children do: [ :child | child notifyWeakFocus: newFocus ]
]

{ #category : #'instance creation' }
MidasContextLauncher >> spawn: aContextClass [
	^aContextClass new
		parentContext: self ;
		yourself
]

{ #category : #accessing }
MidasContextLauncher >> strongFocus [
	^ mooseModel
]

{ #category : #accessing }
MidasContextLauncher >> strongFocus: newFocus [
	self strongFocus = newFocus
		ifTrue: [ ^ self ].
	history addEntry: newFocus.
	self strongFocusFromHistory: newFocus
]

{ #category : #actions }
MidasContextLauncher >> strongFocusFromHistory: newFocus [
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
