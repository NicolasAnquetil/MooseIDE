"
Abstract app. Apps are specialized Spec visualization. All app have a context which is the model of the visualization
"
Class {
	#name : #MidasAbstractApp,
	#superclass : #ComposablePresenter,
	#instVars : [
		'context',
		'chkFreeze',
		'chkHierarchicalFocus',
		'btnFocusOnSelection'
	],
	#category : #'Midas-appGUI'
}

{ #category : #accessing }
MidasAbstractApp >> btnFocusOnSelection [
	^btnFocusOnSelection
]

{ #category : #initialization }
MidasAbstractApp >> canBeFrozen [
	chkFreeze :=
		(self instantiate: CheckBoxPresenter)
			label: 'Freeze content' ;
			whenActivatedDo: [ context freeze ];
			whenDeactivatedDo: [ context unfreeze ] ;
			yourself.
	
	btnFocusOnSelection :=
		self newButton
			label: 'Force focus' ;
			enable ;
			action: [ context focusOnSelection ] ;
			yourself

]

{ #category : #accessing }
MidasAbstractApp >> chkFocusIsHierarchical [
	^chkHierarchicalFocus
		ifNil: [ false ]
		ifNotNil: [ chkHierarchicalFocus state ]
]

{ #category : #accessing }
MidasAbstractApp >> chkFreeze [ 
	^ chkFreeze 
]

{ #category : #accessing }
MidasAbstractApp >> chkHierarchicalFocus [
	^ chkHierarchicalFocus
]

{ #category : #accessing }
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

{ #category : #initialization }
MidasAbstractApp >> focusCanBeHierarchical [
	chkHierarchicalFocus := (self instantiate: CheckBoxPresenter)
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

{ #category : #initialization }
MidasAbstractApp >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: self title.
	aWindowPresenter
		whenClosedDo: [
			context exit.
			context := nil
		]
]

{ #category : #initialization }
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

{ #category : #notifications }
MidasAbstractApp >> updateMidasFocus: focus [
	self subclassResponsibility
]

{ #category : #notifications }
MidasAbstractApp >> updateModel: aMooseModel [
	self updateTitle.
	self updateMidasFocus: aMooseModel
]

{ #category : #api }
MidasAbstractApp >> updateTitle [.
	self window title: self title.
]
