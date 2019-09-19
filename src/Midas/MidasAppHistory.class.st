"
Shows the history of actions
"
Class {
	#name : #MidasAppHistory,
	#superclass : #MidasAbstractAppWithRoassal,
	#instVars : [
		'btnPrev',
		'btnNext',
		'lblName',
		'fldName',
		'btnName'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasAppHistory class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
				add: #btnPrev;
				add: #btnNext)
		withConstraints: [ :constraint | constraint height: self toolbarHeight ];
		add:
			(SpecBoxLayout newHorizontal
				add: #lblName withConstraints: [ :constraint | constraint width: 40 ];
				add: #fldName;
				add: #btnName withConstraints: [ :constraint | constraint width: 60 ])
		withConstraints: [ :constraint | constraint height: self buttonHeight ];
		add: #roassal ;
		yourself
]

{ #category : #accessing }
MidasAppHistory >> btnName [
	^btnName 
]

{ #category : #accessing }
MidasAppHistory >> btnNext [
	^ btnNext
]

{ #category : #accessing }
MidasAppHistory >> btnPrev [
	^ btnPrev
]

{ #category : #displaying }
MidasAppHistory >> drawChainOfEvent [
	| viewElts shape |
	view canvas extent: self viewExtent.
	view @ RTDraggableView.
	view @ RTZoomableView.
	shape := RTCompositeShape new.
	shape add: (RTLabel new text: #entryName).
	shape add: (RTEllipse new
						extent: self entryExtent ;
						color: [ :el | (context current = el) ifTrue: [Color red] ifFalse: [ Color veryLightGray ] ]).
	shape add: (RTLabel new text: '').  "empty text below RTEllipse to turn around a bug in edge building"
	shape vertical.
	viewElts := shape elementsOn: context allEntries.
	viewElts when: TRMouseClick do: [ :event | context userSelection: event element model ].
	viewElts @ (RTPopup new text: [:e | e summaryDescription ]) .
	view addAll: viewElts.
	RTEdgeBuilder new
		view: view;
		elements: viewElts;
		connectToAll: [ :e | e nextEntries ].
	RTHorizontalTreeLayout new
		on: viewElts.
]

{ #category : #accessing }
MidasAppHistory >> entryExtent [
	^ 15 @ 15
]

{ #category : #accessing }
MidasAppHistory >> fldName [
	^fldName 
]

{ #category : #initialization }
MidasAppHistory >> initializeNamingRow [
	lblName := self newLabel
		label: 'name:';
		yourself.
	fldName := self newTextInput
		placeholder: 'Enter the log name...';
		autoAccept: true;
		acceptOnCR: true;
		yourself.
	btnName := self newButton
		label: 'Name it';
		yourself
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
MidasAppHistory >> initializePresenter [
	btnName action: [
		context currentName: fldName text.
		fldName text: ''.
		self refresh
	]
]

{ #category : #initialization }
MidasAppHistory >> initializeWidgets [
	self initializeNextPreviousButtons.
	self initializeNamingRow.
	roassal := self instantiate: RoassalModel.
	roassal
		script: [ :aView :canvas | 
			view := aView.
			self drawChainOfEvent ]
]

{ #category : #displaying }
MidasAppHistory >> refresh [
	self updatePreviousNext.
	roassal refresh
]

{ #category : #notifications }
MidasAppHistory >> updateMidasFocus: focus [
	"never called"
]

{ #category : #notifications }
MidasAppHistory >> updatePreviousNext [
	btnPrev enabled: (context historyHasPrevious).
	btnNext enabled: (context historyHasNext).
]

{ #category : #accessing }
MidasAppHistory >> view [
	^ view
]

{ #category : #accessing }
MidasAppHistory >> viewExtent [
	^ 150 @ 200
]
