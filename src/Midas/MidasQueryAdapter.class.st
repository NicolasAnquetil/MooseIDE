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
				newRow: [ :trow | 
					trow
						newColumn: [ :left | 
							left
								add: #menu height: self toolbarHeight;
								add: #labelNumberListElement height: 30;
								add: #queryWidget height: self toolbarHeight;
								"add: #openResultNewWindowCheckBox height: 30;"
								add: #listView ";
								add: #errorReporter height: 30" ] ] ];
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
	"removing from window
	errorReporter := self instantiate: MVSErrorReportPresenter."
	drawerOptions := MVSDrawerOptionsPresenter new.
	self createQueryWidget.
	"removing from window
	self createOpenResultNewWindowCheckBox."
	menu := self menuBarFor: self.
	labelNumberListElt := self newLabel.
	self initListViewItems: #().	
	self focusOrder
		add: menu;
		add: listView
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
