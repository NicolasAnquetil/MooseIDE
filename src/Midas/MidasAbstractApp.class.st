"
Abstract app. Apps are specialized Spec visualization. All app have a context which is the model of the visualization
"
Class {
	#name : #MidasAbstractApp,
	#superclass : #ComposablePresenter,
	#instVars : [
		'context',
		'freeze'
	],
	#category : #'Midas-apps'
}

{ #category : #accessing }
MidasAbstractApp >> context [
	^ context
]

{ #category : #accessing }
MidasAbstractApp >> context: aContext [
	context = aContext
		ifTrue: [ ^ self ].
	context := aContext.
	aContext app: self
]

{ #category : #accessing }
MidasAbstractApp >> freeze [ 
	^ freeze 
]

{ #category : #accessing }
MidasAbstractApp >> iconNamed: aSymbol [
	^(aSymbol asString beginsWith: 'famix')
	ifTrue: [ MooseIcons perform: aSymbol  ]
	ifFalse: [ Smalltalk ui icons iconNamed: aSymbol ]
]

{ #category : #initialization }
MidasAbstractApp >> initializePresenter [
	super initializePresenter.
	freeze
		whenActivatedDo: [ context freeze ];
		whenDeactivatedDo: [ context unfreeze ].
]

{ #category : #initialization }
MidasAbstractApp >> initializeWidgets [
	freeze := (self instantiate: CheckBoxPresenter)
		label: 'Freeze content' ;
		yourself
]

{ #category : #accessing }
MidasAbstractApp >> mooseModel [
	^ context mooseModel
]

{ #category : #accessing }
MidasAbstractApp >> strongFocus [
	^ context strongFocus
]

{ #category : #notifications }
MidasAbstractApp >> updateModel: aMooseModel [
	self subclassResponsibility
]

{ #category : #notifications }
MidasAbstractApp >> updateStrongFocus: focus [
	self subclassResponsibility
]

{ #category : #api }
MidasAbstractApp >> updateTitle [.
	self window title: self title.
]

{ #category : #notifications }
MidasAbstractApp >> updateWeakFocus: focus [
	self subclassResponsibility
]

{ #category : #accessing }
MidasAbstractApp >> weakFocus [
	^ context weakFocus
]
