"
Abstract app. Apps are specialized Spec visualization. All app have a context which is the model of the visualization
"
Class {
	#name : #MidasAbstractApp,
	#superclass : #ComposablePresenter,
	#instVars : [
		'context',
		'chkFreeze'
	],
	#category : #'Midas-apps'
}

{ #category : #initialization }
MidasAbstractApp >> canBeFrozen [
	chkFreeze := (self instantiate: CheckBoxPresenter)
		label: 'Freeze content' ;
		yourself
]

{ #category : #accessing }
MidasAbstractApp >> chkFreeze [ 
	^ chkFreeze 
]

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
MidasAbstractApp >> iconNamed: aSymbol [
	^(aSymbol asString beginsWith: 'famix')
	ifTrue: [ MooseIcons perform: aSymbol  ]
	ifFalse: [ Smalltalk ui icons iconNamed: aSymbol ]
]

{ #category : #initialization }
MidasAbstractApp >> initializePresenter [
	super initializePresenter.
	chkFreeze ifNotNil: [
		chkFreeze
			whenActivatedDo: [ context freeze ];
			whenDeactivatedDo: [ context unfreeze ]
	]
]

{ #category : #initialization }
MidasAbstractApp >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: self title.
	aWindowPresenter
		whenClosedDo: [
			context exit.
			context := nil
		]
]

{ #category : #accessing }
MidasAbstractApp >> midasFocus [
	^ context midasFocus
]

{ #category : #accessing }
MidasAbstractApp >> mooseModel [
	^ context mooseModel
]

{ #category : #notifications }
MidasAbstractApp >> updateMidasFocus: focus [
	self subclassResponsibility
]

{ #category : #notifications }
MidasAbstractApp >> updateModel: aMooseModel [
	self updateTitle.
]

{ #category : #api }
MidasAbstractApp >> updateTitle [.
	self window title: self title.
]
