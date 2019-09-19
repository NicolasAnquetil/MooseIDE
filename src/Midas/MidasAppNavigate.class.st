"
An app showing navigation links from the current focus
"
Class {
	#name : #MidasAppNavigate,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'properties'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasAppNavigate class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #properties ;
		yourself
]

{ #category : #initialization }
MidasAppNavigate >> initializePresenter [ 
	"-- Not using the 'freeze' checkbox --
	 super initializePresenter."
	properties whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item | context userSelection: item ]
	]
	

]

{ #category : #initialization }
MidasAppNavigate >> initializeWidgets [
	properties := self newList.
	properties
		displayBlock: #name ;
		sortingBlock: #name ascending.

]

{ #category : #accessing }
MidasAppNavigate >> properties [
	^ properties
]

{ #category : #refreshing }
MidasAppNavigate >> refresh [
	properties items: context navigationProperties 
]

{ #category : #TOREMOVE }
MidasAppNavigate >> title [
	^'Navigate ''' , context modelName , ''''
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
