"
An app showing navigation links from the current focus
"
Class {
	#name : #MidasAppNavigate,
	#superclass : #MidasAbstractApp,
	#instVars : [
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

{ #category : #accessing }
MidasAppNavigate >> diagram [
	^ diagram
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
