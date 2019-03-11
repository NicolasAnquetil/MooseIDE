"
Adapter of MVSMainPresenter for Moose IDE
"
Class {
	#name : #MidasQueryAdapter,
	#superclass : #MVSMainPresenter,
	#instVars : [
		'midas'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasQueryAdapter class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :tcol | 
			tcol 
								add: #queryWidget height: self toolbarHeight;
									add: #listView ];
		yourself
]

{ #category : #initialization }
MidasQueryAdapter >> createOpenResultNewWindowCheckBox [
	"removed"
	newSelf := self class withElements: #()
]

{ #category : #initialization }
MidasQueryAdapter >> initializePresenter [
	super initializePresenter.
	"changing doubleClick Behavior"
	listView doubleClickAction: [ :item |
		midas context focus: listView selectedItem ]
]

{ #category : #initialization }
MidasQueryAdapter >> initializeWidgets [
	listView := self instantiate: FastTablePresenter.
	self createQueryWidget.
	menu := self menuBarFor: self.  "not used, but needed by some internal methods"
	self initListViewItems: #()
]

{ #category : #testing }
MidasQueryAdapter >> isOpenResultNewWindow [
	^false
]

{ #category : #actions }
MidasQueryAdapter >> openResultNewWindowCheckBoxEvent [
	"removed"
]

{ #category : #acccessing }
MidasQueryAdapter >> parentApp: aQueryApp [
	midas := aQueryApp  
]

{ #category : #actions }
MidasQueryAdapter >> performQuery [
	midas context focus: (queryWidget performFilterOn: listView listItems)
]

{ #category : #'model - updating' }
MidasQueryAdapter >> updateNavigationButtons [
]

{ #category : #'model - updating' }
MidasQueryAdapter >> updateNumberOfModelElement [
]
