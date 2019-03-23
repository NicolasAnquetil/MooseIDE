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
		'history',
		'focusWeak'
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

{ #category : #accessing }
MidasContextLauncher >> clearHistory [
	history := NavigationHistory new.
	self weakFocus: nil
]

{ #category : #actions }
MidasContextLauncher >> exit [
	children do: [ :child | child exit ].
	children removeAll.
	app delete.
	app := nil
]

{ #category : #initialization }
MidasContextLauncher >> initialize [
	super initialize.
	children := OrderedCollection new.
	self clearHistory
]

{ #category : #accessing }
MidasContextLauncher >> mooseModel [
	^ history isEmpty
		ifTrue: [ nil ]
		ifFalse: [ history first key ]
]

{ #category : #accessing }
MidasContextLauncher >> mooseModel: newMooseModel [
	newMooseModel ifNil: [ ^ self ].
	self mooseModel = newMooseModel
		ifTrue: [ ^ self ].
	self clearHistory.
	history addEntry: newMooseModel.
	self notifyNewModel: newMooseModel
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
	^ history current key "NavigationHistory stores Object->Date and we don't care about the Date"
]

{ #category : #accessing }
MidasContextLauncher >> strongFocus: newFocus [
	self strongFocus = newFocus
		ifTrue: [ ^ self ].
	history addEntry: newFocus.
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
