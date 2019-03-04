Class {
	#name : #IDESubQuery,
	#superclass : #MVSMainPresenter,
	#instVars : [
		'midas'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #specs }
IDESubQuery class >> defaultSpec [
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
IDESubQuery >> createOpenResultNewWindowCheckBox [
	"removed"
	newSelf := self class withElements: #()
]

{ #category : #initialization }
IDESubQuery >> initializePresenter [
	super initializePresenter.
	"changing doubleClick Behavior"
	listView doubleClickAction: [ :item |
		listView selectedItem mvsdoubleClick: self.
		midas context focus: listView selectedItem ]
]

{ #category : #initialization }
IDESubQuery >> initializeWidgets [
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
IDESubQuery >> isOpenResultNewWindow [
	^false
]

{ #category : #actions }
IDESubQuery >> openResultNewWindowCheckBoxEvent [
	"removed"
]

{ #category : #acccessing }
IDESubQuery >> parentApp: aQueryApp [
	midas := aQueryApp  
]
