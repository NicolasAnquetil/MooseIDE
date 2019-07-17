"
An app showing navigation links from the current focus
"
Class {
	#name : #MidasAppNavigate,
	#superclass : #MidasAbstractAppWithRoassal,
	#instVars : [
		'view',
		'btnZoomIn',
		'btnZoomOut',
		'btns',
		'diagram'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppNavigate class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #chkFreeze
			withConstraints: [ :constraints | constraints height: 30 ];
		add: #btns withConstraints: [:const | const height: self buttonHeight ];
		add: #diagram ;
		yourself
]

{ #category : #accessing }
MidasAppNavigate >> btnZoomIn [
	^ btnZoomIn
]

{ #category : #accessing }
MidasAppNavigate >> btnZoomOut [
	^ btnZoomOut
]

{ #category : #accessing }
MidasAppNavigate >> btns [
	^ btns
]

{ #category : #initialization }
MidasAppNavigate >> drawRoassalView [
	| center petals viewElts |
	center := context centralEntity.
	petals := context navigationProperties.
	"composite node: ellipse+text"
	viewElts := ((RTEllipse new extent: 70@30) + (RTLabel new height: 6 ; text: #name)) elementsOn: ({center} , petals).
	viewElts when: TRMouseClick do: [ :event | context selected: event element model ].
	view addAll: viewElts.
	RTEdgeBuilder new
		view: view;
		elements: viewElts;
		connectToAll: [ :e | (e = center) ifTrue: [ petals ] ifFalse: [ #() ]  ].
	RTRadialTreeLayout new
		horizontalGap: 100 ;
		verticalGap: 100 ;
		on: viewElts.
	view canvas focusOnCenterScaled.

]

{ #category : #initialization }
MidasAppNavigate >> initializeWidgets [
	super initializeWidgets.
	btnZoomIn := self newButton label: '+' ; action: [ RTZoomInMove on: view ].
	btnZoomOut := self newButton label: '-' ; action: [ RTZoomOutMove on: view ].
	btns := self newButtonBar.
	btns add: btnZoomIn ; add: btnZoomOut.
	diagram := self instantiate: RoassalModel.	
	diagram script: [ :aView :canvas |
		self view: aView.
		self drawRoassalView
	].

]

{ #category : #refreshing }
MidasAppNavigate >> refresh [
	diagram refresh
]

{ #category : #notifications }
MidasAppNavigate >> updateModel: aMooseModel [
	self refresh
]

{ #category : #notifications }
MidasAppNavigate >> updateStrongFocus: focus [
	self refresh
]

{ #category : #notifications }
MidasAppNavigate >> updateWeakFocus: focus [
	self refresh
]

{ #category : #accessing }
MidasAppNavigate >> view [
	^ view
]

{ #category : #accessing }
MidasAppNavigate >> view: anObject [
	view := anObject
]
