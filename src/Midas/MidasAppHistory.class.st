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
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #btnPrev;
				add: #btnNext;
				yourself)
		withConstraints: [ :constraint | constraint height: self toolbarHeight ];
		add:
			(SpBoxLayout newHorizontal
				add: #lblName withConstraints: [ :constraint | constraint width: 40 ];
				add: #fldName;
				add: #btnName withConstraints: [ :constraint | constraint width: 60 ];
				yourself)
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

{ #category : #notifications }
MidasAppHistory >> displayFocus: focus [
	"never called"
]

{ #category : #accessing }
MidasAppHistory >> entryExtent [
	^ 15 @ 15
]

{ #category : #displaying }
MidasAppHistory >> entryPopupBlock [
	"a block to compute the popup text of an history entry"
	^ [ :historyEntry | historyEntry summaryDescription ]
]

{ #category : #accessing }
MidasAppHistory >> fldName [
	^fldName 
]

{ #category : #initialization }
MidasAppHistory >> initialize [
	super initialize.
	view := RTView new.
	SpMorphPresenter new
		morph: view canvas buildMorph;
	yourself
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
	super initializePresenter.
	btnName action: [
		context currentName: fldName text.
		fldName text: ''.
		self refresh
	]
]

{ #category : #initialization }
MidasAppHistory >> initializeWidgets [
	super initializeWidgets.
	self initializeNextPreviousButtons.
	self initializeNamingRow.

]

{ #category : #displaying }
MidasAppHistory >> refresh [
	super refresh.
	self updatePreviousNext.
]

{ #category : #displaying }
MidasAppHistory >> roassalScript [
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
	viewElts := shape elementsOn: self viewElements.
	viewElts when: TRMouseClick do: [ :event | context userSelection: event element model ].
	viewElts @ (RTPopup new text: self entryPopupBlock) .
	view addAll: viewElts.
	RTEdgeBuilder new
		view: view;
		elements: viewElts;
		connectToAll: [ :e | e nextEntries ].
	RTHorizontalTreeLayout new
		on: viewElts.
]

{ #category : #notifications }
MidasAppHistory >> updatePreviousNext [
	btnPrev enabled: (context notNil and: [context historyHasPrevious]).
	btnNext enabled: (context notNil and: [context historyHasNext]).
]

{ #category : #accessing }
MidasAppHistory >> view [
	^ view
]

{ #category : #accessing }
MidasAppHistory >> viewElements [
	^context 	ifNil: [ #() ] ifNotNil: [ context allEntries ]
]

{ #category : #accessing }
MidasAppHistory >> viewExtent [
	^ 150 @ 200
]
