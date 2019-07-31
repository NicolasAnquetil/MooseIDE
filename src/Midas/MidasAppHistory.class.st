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

{ #category : #'as yet unclassified' }
MidasAppHistory >> drawChainOfEvent [
	| viewElts |
	view canvas extent: self viewSize.
	view @ RTDraggableView.
	view @ RTZoomableView.
	viewElts := (RTEllipse new
						extent: self entrySize ;
						color: [ :el | (context current = el key) ifTrue: [Color red] ifFalse: [ Color veryLightGray ] ])
						elementsOn: context history.
	viewElts when: TRMouseClick do: [ :event | context selected: event element model ].
	viewElts @ (RTPopup new text: [:e | context summaryDescriptionFor: e]) .
	view addAll: viewElts.
	RTEdgeBuilder new
		view: view;
		elements: viewElts;
		connectTo: [ :e | context nextInHistory: e ].
	RTHorizontalTreeLayout new
		on: viewElts.
]

{ #category : #accessing }
MidasAppHistory >> entrySize [
	^ 15 @ 15
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
	roassal
		script: [ :aView :canvas | 
			view := aView.
			self drawChainOfEvent ]
]

{ #category : #refreshing }
MidasAppHistory >> refresh [
	self updatePreviousNext.
	roassal refresh
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
MidasAppHistory >> viewSize [
	^ 150 @ 200
]
