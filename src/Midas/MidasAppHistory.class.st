"
Shows the history of actions
"
Class {
	#name : #MidasAppHistory,
	#superclass : #MidasAbstractAppWithRoassal,
	#instVars : [
		'btnPrev',
		'btnNext'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppHistory class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
				add: #btnPrev;
				add: #btnNext)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #roassal ;
		yourself
]

{ #category : #accessing }
MidasAppHistory >> btnNext [
	^ btnNext
]

{ #category : #accessing }
MidasAppHistory >> btnPrev [
	^ btnPrev
]

{ #category : #initialization }
MidasAppHistory >> drawChainOfEvent [
	| viewElts |
	viewElts := (RTEllipse new extent: 15@15) elementsOn: context history.
	viewElts when: TRMouseClick do: [ :event | context selected: event element model ].
	viewElts @ (RTPopup new text: [:e | context summaryDescriptionFor: e]) .
	view addAll: viewElts.
	RTEdgeBuilder new
		view: view;
		elements: viewElts;
		connectTo: [ :e | context nextInHistory: e ].
	RTHorizontalTreeLayout new
		on: viewElts.
	self focusOnCurrent.
]

{ #category : #refreshing }
MidasAppHistory >> focusOnCurrent [
	view canvas focusOnCenterScaled
	"focusOnCenterScaled: aFactor
	| sc rec |
	canvas numberOfShapes = 0 ifTrue: [ ^ self ].
	rec := self encompassingRectangle.
	self translateTo: rec center.
	sc := aFactor / ((rec extent) max: 1 @ 1).
	sc := (sc x < sc y) ifTrue: [sc x] ifFalse: [ sc y ].
	self scale: sc.
	^ sc"
]

{ #category : #initialization }
MidasAppHistory >> initializeNextPreviousButtons [
	btnPrev := self newButton.
	btnPrev
		disable ;
		icon: (self iconNamed: #smallUndoIcon);
		action: [ context prev ].
	btnNext := self newButton.
	btnNext
		disable ;
		icon: (self iconNamed: #smallRedoIcon);
		action: [ context next ].

]

{ #category : #initialization }
MidasAppHistory >> initializeWidgets [
	self initializeNextPreviousButtons.
	roassal := self instantiate: RoassalModel.	
	roassal script: [ :aView :canvas |
		view := aView.
		self drawChainOfEvent
	].
]

{ #category : #refreshing }
MidasAppHistory >> refresh [
	roassal refresh
]

{ #category : #notifications }
MidasAppHistory >> updatePreviousNext [
	btnPrev enabled: (context historyHasPrevious).
	btnNext enabled: (context historyHasNext).
	self refresh
]

{ #category : #notifications }
MidasAppHistory >> updateStrongFocus: focus [
	self updatePreviousNext
]

{ #category : #notifications }
MidasAppHistory >> updateWeakFocus: newFocus [
	self shouldNotImplement
]
