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
		'mooseModel',
		'strongFocus',
		'weakFocus'
	],
	#category : #'Midas-context'
}

{ #category : #actions }
MidasContextLauncher >> addChild: aContext [
	(children includes: aContext)
		ifTrue: [ ^ self ].
	children add: aContext.
	aContext parentContext: self
]

{ #category : #actions }
MidasContextLauncher >> children [
	^children
]

{ #category : #actions }
MidasContextLauncher >> exit [
	|cachedChildren|
	cachedChildren := children copy.
	cachedChildren do: [ :child | child exit ].
	app ifNotNil: [ app delete].
	app := nil
]

{ #category : #accessing }
MidasContextLauncher >> hasEntities [
	^ children anySatisfy: [ :each | each class = MidasContextEntities ]
]

{ #category : #initialization }
MidasContextLauncher >> initialize [
	super initialize.
	children := OrderedCollection new.
]

{ #category : #accessing }
MidasContextLauncher >> midasFocus [
	^ strongFocus
]

{ #category : #accessing }
MidasContextLauncher >> midasFocus: newFocus [
	self midasFocus = newFocus
		ifTrue: [ ^ self ].
	strongFocus := newFocus.
	"note: setting strongFocus _sets_ weakFocus but does not _notify_ weakFocus"
	weakFocus := newFocus.
	self notifyStrongFocus: newFocus.
]

{ #category : #accessing }
MidasContextLauncher >> mooseModel [
	^ mooseModel
]

{ #category : #accessing }
MidasContextLauncher >> mooseModel: newMooseModel [
	newMooseModel ifNil: [ ^ self ].
	self mooseModel = newMooseModel
		ifTrue: [ ^ self ].
	mooseModel := newMooseModel.
	"note: setting model _sets_ strong and weak focuses but does not _notify_ strong and weak focuses"
	strongFocus := newMooseModel.
	weakFocus := newMooseModel.
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

{ #category : #actions }
MidasContextLauncher >> removeChild: aContext [
	(children includes: aContext)
		ifFalse: [ ^ self ].
	children remove: aContext.
]

{ #category : #'instance creation' }
MidasContextLauncher >> spawn: aContextClass [
	^aContextClass new
		parentContext: self ;
		yourself
]

{ #category : #accessing }
MidasContextLauncher >> strongFocusIsModel [
	^ mooseModel = strongFocus
]
