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
		'midasFocus'
	],
	#category : #'Midas-appModel'
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

{ #category : #initialization }
MidasContextLauncher >> initializeMooseModel: aMooseModel [
	self mooseModel: (MidasEntityMooseModel with: aMooseModel)

]

{ #category : #accessing }
MidasContextLauncher >> midasFocus [
	^ midasFocus
]

{ #category : #notifications }
MidasContextLauncher >> midasFocus: newFocus [
	self midasFocus = newFocus
		ifTrue: [ ^ self ].
	midasFocus := newFocus.
	self notifyMidasFocus: newFocus.
]

{ #category : #accessing }
MidasContextLauncher >> mooseModel [
	^ mooseModel
]

{ #category : #notifications }
MidasContextLauncher >> mooseModel: newMooseModel [
	mooseModel := newMooseModel.
	"note: setting model _sets_ focus but does not _notify_ focus (notifies model)"
	midasFocus := mooseModel.
	self notifyNewModel: mooseModel
]

{ #category : #accessing }
MidasContextLauncher >> mooseModelAsGroups [
	^ self mooseModel
		ifNotNil: [ :model |
			model entityCache 
				associationsSelect: [ :a | a key isString and: [a key beginsWith: 'All model']
		]
	]
]

{ #category : #notifications }
MidasContextLauncher >> notifyMidasFocus: newFocus [
	children do: [ :child | child notifyMidasFocus: newFocus]
]

{ #category : #notifications }
MidasContextLauncher >> notifyNewModel: newMooseModel [
	app updateModel: newMooseModel.
	children do: [ :child | child notifyNewModel: newMooseModel ]
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
