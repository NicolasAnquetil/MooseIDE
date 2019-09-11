"
An app showing navigation links from the current focus
"
Class {
	#name : #MidasAppNavigate,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'diagram'
	],
	#category : #'Midas-gui'
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
		selection selectedItem ifNotNil: [ :item | context userSelection: item ]
	]
	

]

{ #category : #initialization }
MidasAppNavigate >> initializeWidgets [
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
MidasAppNavigate >> updateMidasFocus: focus [
	self refresh
]

{ #category : #notifications }
MidasAppNavigate >> updateModel: aMooseModel [
	super updateModel: aMooseModel.
	self refresh
]
