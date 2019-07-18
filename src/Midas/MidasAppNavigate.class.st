"
An app showing navigation links from the current focus
"
Class {
	#name : #MidasAppNavigate,
	#superclass : #MidasAbstractAppWithRoassal,
	#instVars : [
		'view',
		'diagram'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppNavigate class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #diagram ;
		yourself
]

{ #category : #initialization }
MidasAppNavigate >> drawRoassalView [
	"graphical display, no longer used, now done with a list"
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
MidasAppNavigate >> initializePresenter [ 
	"-- Not using the 'freeze' checkbox --
	 super initializePresenter."
	diagram whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item | context selected: item ]
	]
	

]

{ #category : #initialization }
MidasAppNavigate >> initializeWidgets [
	"-- Not using the 'freeze' checkbox --
	 super initializeWidgets."
	
	"graphical display, no longer used, now done with a list
	diagram := self instantiate: RoassalModel.	
	diagram script: [ :aView :canvas |
		self view: aView.
		self drawRoassalView
	]."
	diagram := self newList.
	diagram
		displayBlock: #name ;
		sortingBlock: #name ascending.

]

{ #category : #refreshing }
MidasAppNavigate >> refresh [
	diagram items: context navigationProperties 
]

{ #category : #TOREMOVE }
MidasAppNavigate >> title [
	^'MIDAS Navigate: ''' , context modelName , ''''
]

{ #category : #notifications }
MidasAppNavigate >> updateModel: aMooseModel [
	super updateModel: aMooseModel.
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
