"
Abstract app. Apps are specialized Spec visualization. All app have a context which is the model of the visualization
"
Class {
	#name : #MidasAbstractApp,
	#superclass : #SpPresenter,
	#instVars : [
		'context',
		'chkFreeze',
		'chkHierarchicalFocus',
		'btnBypassFreeze',
		'initialPosition'
	],
	#category : #'Midas-appGUI'
}

{ #category : #'as yet unclassified' }
MidasAbstractApp class >> standAlone [
	| emptyContext |
	emptyContext := Mock new.
	self new
		context: emptyContext ;
		openWithSpec
]

{ #category : #freezeUnfreeze }
MidasAbstractApp >> btnBypassFreeze [
	^btnBypassFreeze
]

{ #category : #freezeUnfreeze }
MidasAbstractApp >> canBeFrozen [
	chkFreeze :=
		(self instantiate: SpCheckBoxPresenter)
			label: 'Freeze content' ;
			whenActivatedDo: [ context freeze ];
			whenDeactivatedDo: [ context unfreeze ] ;
			yourself.
	
	btnBypassFreeze :=
		self newButton
			label: 'Bypass freeze' ;
			enable ;
			action: [ context bypassFreeze ] ;
			yourself

]

{ #category : #flatHierarchical }
MidasAbstractApp >> chkFocusIsHierarchical [
	^chkHierarchicalFocus
		ifNil: [ false ]
		ifNotNil: [ chkHierarchicalFocus state ]
]

{ #category : #freezeUnfreeze }
MidasAbstractApp >> chkFreeze [ 
	^ chkFreeze 
]

{ #category : #flatHierarchical }
MidasAbstractApp >> chkHierarchicalFocus [
	^ chkHierarchicalFocus
]

{ #category : #freezeUnfreeze }
MidasAbstractApp >> chkIsFrozen [
	^ chkFreeze
		ifNil: [ false ]
		ifNotNil: [ chkFreeze state ] 
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
	aContext app: self.
	
	self chkIsFrozen
		ifTrue:  [ aContext freeze ];
		ifFalse: [ aContext unfreeze ]
]

{ #category : #freezeUnfreeze }
MidasAbstractApp >> disableBtnBypassFreeze [
	btnBypassFreeze ifNotNil: [ btnBypassFreeze disable ]
]

{ #category : #notifications }
MidasAbstractApp >> displayModel: aMooseModel [
	"updates the representation of the GUI when a new model is selected"
	self updateTitle.
	self displayFocus: aMooseModel
]

{ #category : #freezeUnfreeze }
MidasAbstractApp >> enableBtnBypassFreeze [
	btnBypassFreeze ifNotNil: [ btnBypassFreeze enable ]
]

{ #category : #flatHierarchical }
MidasAbstractApp >> focusCanBeHierarchical [
	chkHierarchicalFocus := (self instantiate: SpCheckBoxPresenter)
		label: 'Hierarchical view';
		whenActivatedDo: [ context focusBeHierarchical ];
		whenDeactivatedDo: [ context focusBeFlat ] ;
		yourself.

]

{ #category : #accessing }
MidasAbstractApp >> iconNamed: aSymbol [
	^(aSymbol asString beginsWith: 'famix')
	ifTrue: [ MooseIcons perform: aSymbol  ]
	ifFalse: [ Smalltalk ui icons iconNamed: aSymbol ]
]

{ #category : #accessing }
MidasAbstractApp >> initialPosition [
	^initialPosition
]

{ #category : #accessing }
MidasAbstractApp >> initialPosition: aPoint [
	initialPosition := aPoint
]

{ #category : #initialization }
MidasAbstractApp >> initializeWindow: aWindowPresenter [
	aWindowPresenter initialPosition: self initialPosition.
	aWindowPresenter title: self title.
	aWindowPresenter
		whenClosedDo: [
			context exit.
			context := nil
		]
]

{ #category : #freezeUnfreeze }
MidasAbstractApp >> isFrozen [
	chkFreeze ifNil: [ ^false ].
	^chkFreeze isActivated 
]

{ #category : #accessing }
MidasAbstractApp >> midasFocus [
	^ context midasFocus
]

{ #category : #accessing }
MidasAbstractApp >> mooseModel [
	^ context mooseModel
]

{ #category : #api }
MidasAbstractApp >> updateTitle [.
	self window title: self title.
]
