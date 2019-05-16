"
An app to select entities from the current model
"
Class {
	#name : #MidasAppQuery,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'chkAssociation',
		'mnuSelcol',
		'lblEach',
		'fldQuery',
		'btnQuery',
		'lstEntities',
		'btnPrev',
		'btnNext'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppQuery class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :c | 
			c
				newRow: [ :r |
					r
						add: #freeze ;
						add: #chkAssociation ;
						add: #btnPrev ;
						add: #btnNext
					]  height: 30 ;
				newRow: [ :r |
					r
						add: #mnuSelcol width: 80 ;
						add: #lblEach width: 70 ;
						add: #fldQuery ;
						add: #btnQuery width: 30
					] height: 30 ;
				add: #lstEntities 
			] ;
		yourself
]

{ #category : #specs }
MidasAppQuery class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #accessing }
MidasAppQuery >> btnNext [
	^ btnNext
]

{ #category : #accessing }
MidasAppQuery >> btnPrev [
	^ btnPrev
]

{ #category : #accessing }
MidasAppQuery >> btnQuery [
	^ btnQuery
]

{ #category : #notifications }
MidasAppQuery >> checkPreviousNext [
	btnPrev enabled: (context historyHasPrevious and: [context frozen not]).
	btnNext enabled: (context historyHasNext and: [context frozen not]).
	
]

{ #category : #accessing }
MidasAppQuery >> chkAssociation [
	^ chkAssociation
]

{ #category : #accessing }
MidasAppQuery >> context: aContext [
	super context: aContext.
]

{ #category : #accessing }
MidasAppQuery >> fldQuery [
	^ fldQuery
]

{ #category : #initialization }
MidasAppQuery >> initializePresenter [
	freeze
		whenActivatedDo: [ self checkPreviousNext. context freeze ];
		whenDeactivatedDo: [ self checkPreviousNext. context unfreeze ].
	chkAssociation
		whenActivatedDo: [ context trackAssociation ];
		whenDeactivatedDo: [ context flattenResult ].
	lstEntities
		whenSelectedItemChanged: [ :item | context selectedWeakFocus: item ] ;
		doubleClickAction: [ :item | context selectedStrongFocus: lstEntities selectedItem ]
]

{ #category : #initialization }
MidasAppQuery >> initializeWidgetHistoryMenu [
	btnPrev := self newButton.
	btnPrev
		disable ;
		icon: (self iconNamed: #smallUndoIcon);
		action: [ context prev ].
	btnNext := self newButton.
	btnNext
		disable ;
		icon: (self iconNamed: #smallRedoIcon);
		action: [ context next ].

]

{ #category : #initialization }
MidasAppQuery >> initializeWidgetListEntities [
	lstEntities := self instantiate: FastTablePresenter.
	lstEntities
		displayBlock: [ :asso |
			asso key = asso value
				ifTrue: [ asso value asString ]
				ifFalse: [ '- ' , asso value asString ]
		];
		icons: [ :item | item mooseIcon ];
		sortingBlock: [ :assoA :assoB |
			(assoA key = assoB key)
				ifTrue: [ (assoA key = assoA value)
								ifTrue: [ true ]
								ifFalse: [
									(assoB key = assoB value)
										ifTrue: [  false ]
										ifFalse: [ assoA value asString < assoB value asString]
								]
				]
				ifFalse: [ assoA key asString < assoB key asString ]
		]
]

{ #category : #initialization }
MidasAppQuery >> initializeWidgets [
	super initializeWidgets.
	chkAssociation := (self instantiate: CheckBoxPresenter)
		label: 'Result as tree';
		yourself.
	self initializeWidgetHistoryMenu.
	self initializeWidgetsQueryRow.
	self initializeWidgetListEntities
]

{ #category : #initialization }
MidasAppQuery >> initializeWidgetsQueryRow [
	mnuSelcol := self newDropList.
	mnuSelcol
		items: #(#filter #navigate);
		displayBlock: [ :i | i asString ].
	lblEach := self newLabel.
	lblEach label: 'each where:'.
	fldQuery := self newTextInput.
	btnQuery := self newButton.
	btnQuery label: 'run'.
	btnQuery action: self runQueryButtonAction
]

{ #category : #accessing }
MidasAppQuery >> lblEach [
	^ lblEach
]

{ #category : #accessing }
MidasAppQuery >> lstEntities [
	^ lstEntities
]

{ #category : #accessing }
MidasAppQuery >> mnuSelcol [
	^ mnuSelcol
]

{ #category : #initialization }
MidasAppQuery >> runQueryButtonAction [
	^[ context interpretQuery: mnuSelcol selectedItem withBody: fldQuery getText  ]
]

{ #category : #api }
MidasAppQuery >> title [
	^'MIDAS Query' 
]

{ #category : #notifications }
MidasAppQuery >> updateStrongFocus: focus [
	lstEntities items: focus.
	self checkPreviousNext
	
]

{ #category : #notifications }
MidasAppQuery >> updateWeakFocus: focus [
	lstEntities resetSelection.
	lstEntities setSelectedItem: focus
]
