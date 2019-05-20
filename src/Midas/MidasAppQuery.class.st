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
		'mnuScope',
		'lstEntities',
		'btnPrev',
		'btnNext',
		'filterQuery'
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
				add: #mnuScope height: 30 ;
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
MidasAppQuery >> filterQuery [
	^ filterQuery
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
		doubleClickAction: [ :item | context selectedStrongFocus: lstEntities selectedItem ].
	mnuSelcol
		whenSelectedItemChanged: [ :item | filterQuery := (item = #filter) ]
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
		displayBlock: [ :entity | entity formatWithParent: context resultsWithParents ];
		icons: [ :item | item mooseIcon ];
		sortingBlock: [ :entityA :entityB | entityA lessThan: entityB ]
]

{ #category : #initialization }
MidasAppQuery >> initializeWidgets [
	super initializeWidgets.
	chkAssociation := (self instantiate: CheckBoxPresenter)
		label: 'Result as tree';
		yourself.
	self initializeWidgetHistoryMenu.
	self initializeWidgetsQueryRow.
	self initializeWidgetsScopeRow.
	self initializeWidgetListEntities
]

{ #category : #initialization }
MidasAppQuery >> initializeWidgetsQueryRow [
	mnuSelcol := self newDropList.
	mnuSelcol
		items: #(#filter #navigate);
		displayBlock: [ :i | i asString ].
	filterQuery := true.  "by default will be on #filter"
	lblEach := self newLabel.
	lblEach label: 'each where:'.
	fldQuery := self newTextInput.
	btnQuery := self newButton.
	btnQuery label: 'run'.
	btnQuery action: self runQueryButtonAction
]

{ #category : #initialization }
MidasAppQuery >> initializeWidgetsScopeRow [
	mnuScope := self instantiate: MenuPresenter.
	mnuScope addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: 'Package';
						description: 'Packages';
						icon: (self iconNamed: #famixPackageGroup);
						action: [ context packageScope ] ].
			group
				addItem: [ :item | 
					item
						name: 'Classes' ;
						description: 'Classes';
						icon: (self iconNamed: #famixClassGroup);
						action: [ context classScope ] ].
			group
				addItem: [ :item | 
					item
						name: 'Methods' ;
						description: 'Methods';
						icon: (self iconNamed: #famixMethodGroup);
						action: [ context methodScope ] ].

	].
	"mnuScope applyTo: self"

]

{ #category : #accessing }
MidasAppQuery >> lblEach [
	^ lblEach
]

{ #category : #accessing }
MidasAppQuery >> lstEntities [
	^ lstEntities
]

{ #category : #Accessing }
MidasAppQuery >> mnuScope [
	^ mnuScope
]

{ #category : #accessing }
MidasAppQuery >> mnuSelcol [
	^ mnuSelcol
]

{ #category : #running }
MidasAppQuery >> runQueryButtonAction [
	^[ context interpretQuery: fldQuery getText  ]
]

{ #category : #api }
MidasAppQuery >> title [
	^'MIDAS Query' 
]

{ #category : #notifications }
MidasAppQuery >> updateModel: mooseModel [
	self updateStrongFocus: mooseModel
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
