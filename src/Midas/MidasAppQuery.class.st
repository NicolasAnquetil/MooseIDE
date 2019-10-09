Class {
	#name : #MidasAppQuery,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'mnuSelcol',
		'filterQuery',
		'fldQuery',
		'btnQuery',
		'lstProperties',
		'lblProperties'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasAppQuery class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
				add: #mnuSelcol
					withConstraints: [ :constraints | constraints width: 80 ];
				add: ' each where:'
					withConstraints: [ :constraints | constraints width: 75 ];
				add: #fldQuery;
				add: #btnQuery
					withConstraints: [ :constraints | constraints width: 30 ])
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #lblProperties withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #lstProperties ;
		yourself
]

{ #category : #accessing }
MidasAppQuery >> btnQuery [
	^ btnQuery
]

{ #category : #refreshing }
MidasAppQuery >> clearSelection [
	lstProperties unselectAll
]

{ #category : #accessing }
MidasAppQuery >> filterQuery [
	^ filterQuery
]

{ #category : #accessing }
MidasAppQuery >> fldQuery [
	^ fldQuery
]

{ #category : #initialization }
MidasAppQuery >> initializePresenter [ 
	"-- Not using the 'freeze' checkbox --
	 super initializePresenter."
	lstProperties whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item | context userSelection: item ]
	]
	

]

{ #category : #initialization }
MidasAppQuery >> initializeWidgets [
	self initializeWidgetsQueryRow.
	lblProperties := self newLabel
							label: 'Available properties:'.
	
	lstProperties := self newList.
	lstProperties
		displayBlock: #name ;
		sortingBlock: #name ascending.

]

{ #category : #initialization }
MidasAppQuery >> initializeWidgetsQueryRow [
	mnuSelcol := self newDropList.
	mnuSelcol
		items: #(#filter #navigate);
		displayBlock: [ :i | i asString ].
	filterQuery := true.	"by default will be on #filter"
	fldQuery := self newTextInput.
	btnQuery := self newButton.
	btnQuery label: 'run'.
	btnQuery action: self runQueryButtonAction
]

{ #category : #accessing }
MidasAppQuery >> lblProperties [
	^lblProperties
]

{ #category : #accessing }
MidasAppQuery >> lstProperties [
	^ lstProperties
]

{ #category : #accessing }
MidasAppQuery >> mnuSelcol [
	^ mnuSelcol
]

{ #category : #refreshing }
MidasAppQuery >> refresh [
	lstProperties items: context navigationProperties 
]

{ #category : #running }
MidasAppQuery >> runQueryButtonAction [
	^[ context interpretQuery: fldQuery getText  ]
]

{ #category : #accessing }
MidasAppQuery >> selectedItems [
	^ lstProperties selectedItems
]

{ #category : #initialization }
MidasAppQuery >> title [
	^'Navigate ''' , context modelName , ''''
]

{ #category : #notifications }
MidasAppQuery >> updateMidasFocus: focus [
	self refresh.
	self clearSelection
]
