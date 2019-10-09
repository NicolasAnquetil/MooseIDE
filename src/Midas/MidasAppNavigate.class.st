"
An app showing navigation links from the current focus
"
Class {
	#name : #MidasAppNavigate,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'lstProperties'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasAppNavigate class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #lstProperties ;
		yourself
]

{ #category : #refreshing }
MidasAppNavigate >> clearSelection [
	lstProperties unselectAll
]

{ #category : #initialization }
MidasAppNavigate >> initializePresenter [ 
	"-- Not using the 'freeze' checkbox --
	 super initializePresenter."
	lstProperties whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item | context userSelection: item ]
	]
	

]

{ #category : #initialization }
MidasAppNavigate >> initializeWidgets [
	lstProperties := self newList.
	lstProperties
		displayBlock: #name ;
		sortingBlock: #name ascending.

]

{ #category : #accessing }
MidasAppNavigate >> lstProperties [
	^ lstProperties
]

{ #category : #refreshing }
MidasAppNavigate >> refresh [
	lstProperties items: context navigationProperties 
]

{ #category : #accessing }
MidasAppNavigate >> selectedItems [
	^ lstProperties selectedItems
]

{ #category : #initialization }
MidasAppNavigate >> title [
	^'Navigate ''' , context modelName , ''''
]

{ #category : #notifications }
MidasAppNavigate >> updateMidasFocus: focus [
	self refresh.
	self clearSelection
]
