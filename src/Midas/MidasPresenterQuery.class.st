Class {
	#name : #MidasPresenterQuery,
	#superclass : #SpPresenter,
	#instVars : [
		'mnuSelcol',
		'filterQuery',
		'fldQuery',
		'btnQuery',
		'lstProperties'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasPresenterQuery class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #mnuSelcol
					withConstraints: [ :constraints | constraints width: 80 ];
				add: ' each where:'
					withConstraints: [ :constraints | constraints width: 75 ];
				add: #fldQuery;
				add: #btnQuery
					withConstraints: [ :constraints | constraints width: 30 ])
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: 'Available properties:'
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #lstProperties ;
		yourself
]

{ #category : #accessing }
MidasPresenterQuery >> btnQuery [
	^ btnQuery
]

{ #category : #refreshing }
MidasPresenterQuery >> clearUI [
	lstProperties unselectAll.
	fldQuery text: ''
]

{ #category : #notifications }
MidasPresenterQuery >> displayFocus: focus [
	self refresh.
	self clearUI
]

{ #category : #accessing }
MidasPresenterQuery >> fldQuery [
	^ fldQuery
]

{ #category : #initialization }
MidasPresenterQuery >> initializePresenter [ 

	lstProperties whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item | owner userSelection: item ]
	].
	mnuSelcol whenSelectedItemChangedDo: [ :selected | owner queryIsFilter: (selected = #filter) ].
	btnQuery action: self runQueryButtonAction
]

{ #category : #initialization }
MidasPresenterQuery >> initializeWidgets [
	self initializeWidgetsQueryRow.
	lstProperties := self newList.
	lstProperties
		display: #name;
		sortingBlock: #name ascending
]

{ #category : #initialization }
MidasPresenterQuery >> initializeWidgetsQueryRow [
	mnuSelcol := self newDropList.
	mnuSelcol
		items: #(#filter #navigate);
		display: [ :i | i asString ].
	filterQuery := true.	"by default will be on #filter"
	fldQuery := self newTextInput.
	btnQuery := self newButton.
	btnQuery label: 'run'.
]

{ #category : #accessing }
MidasPresenterQuery >> lstProperties [
	^ lstProperties
]

{ #category : #accessing }
MidasPresenterQuery >> mnuSelcol [
	^ mnuSelcol
]

{ #category : #accessing }
MidasPresenterQuery >> mnuSelcolSelect: anInt [
	mnuSelcol selectIndex: anInt
]

{ #category : #refreshing }
MidasPresenterQuery >> refresh [
	lstProperties items: owner navigationProperties 
]

{ #category : #running }
MidasPresenterQuery >> runQueryButtonAction [
	^ [ owner interpretQuery: fldQuery text ]
]

{ #category : #accessing }
MidasPresenterQuery >> selectPropertyAtIndex: anInt [
	lstProperties clickAtIndex: anInt
]

{ #category : #accessing }
MidasPresenterQuery >> selectedItems [
	^ lstProperties selectedItems
]
