"
An app to select entities from the current model
"
Class {
	#name : #MidasAppQuery,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'chkAssociation',
		'mnuSelcol',
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
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
				add: #freeze;
				add: #chkAssociation;
				add: #btnPrev;
				add: #btnNext)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
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
		add: #mnuScope
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #lstEntities;
		yourself
]

{ #category : #specs }
MidasAppQuery class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #accessing }
MidasAppQuery >> btnClassScope [
	^mnuScope menuGroups first menuItems second
]

{ #category : #accessing }
MidasAppQuery >> btnMethodScope [
	^mnuScope menuGroups first menuItems third
]

{ #category : #accessing }
MidasAppQuery >> btnNext [
	^ btnNext
]

{ #category : #accessing }
MidasAppQuery >> btnPackageScope [
	^mnuScope menuGroups first menuItems first
]

{ #category : #accessing }
MidasAppQuery >> btnPrev [
	^ btnPrev
]

{ #category : #accessing }
MidasAppQuery >> btnQuery [
	^ btnQuery
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
^fldQuery
]

{ #category : #accessing }
MidasAppQuery >> freeze [
^freeze
]

{ #category : #initialization }
MidasAppQuery >> initializePresenter [
	freeze
		whenActivatedDo: [ context freeze ];
		whenDeactivatedDo: [ context unfreeze ].
	chkAssociation
		whenActivatedDo: [ context trackAssociation ];
		whenDeactivatedDo: [ context flattenResult ].
	lstEntities
		whenSelectionChangedDo: [ :selection | 
			[ :item | context selectedWeakFocus: item ]
				cull: selection selectedItem ];
		doubleClickAction:
				[ :item | context selectedStrongFocus: lstEntities selection selectedItem ].
	mnuSelcol
		whenSelectedItemChangedDo: [ :item | filterQuery := item = #filter ]
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
	lstEntities := self instantiate: ListPresenter.
	lstEntities contextMenu: self listMenu.
	lstEntities
		displayBlock: [ :entity | entity displayWithParent: context resultsWithParents ];
		icons: [ :item | item mooseIcon ]";
		sortingBlock: [ :entityA :entityB | entityA lessThan: entityB ]"
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
	filterQuery := true.	"by default will be on #filter"
	fldQuery := self newTextInput.
	btnQuery := self newButton.
	btnQuery label: 'run'.
	btnQuery action: self runQueryButtonAction
]

{ #category : #initialization }
MidasAppQuery >> initializeWidgetsScopeRow [
	mnuScope := self newMenuBar.
	mnuScope
		addGroup: [ :group | 
			"mnuScope applyTo: self"
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
						name: 'Classes';
						description: 'Classes';
						icon: (self iconNamed: #famixClassGroup);
						action: [ context classScope ] ].
			group
				addItem: [ :item | 
					item
						name: 'Methods';
						description: 'Methods';
						icon: (self iconNamed: #famixMethodGroup);
						action: [ 
							context methodScope ] ] ]
]

{ #category : #initialization }
MidasAppQuery >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: self title.
	aWindowPresenter
		whenClosedDo: [ context strongFocus: context mooseModel.
			context exit ]
]

{ #category : #menu }
MidasAppQuery >> listMenu [
	^ self newMenu
		addItem: [ :anItem | 
			anItem
				name: 'Inspect';
				icon: (self iconNamed: #smallInspectIt);
				action: [ lstEntities selection selectedItem inspect ] ]
]

{ #category : #accessing }
MidasAppQuery >> lstEntities [
	^ lstEntities
]

{ #category : #accessing }
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
	^'MIDAS Query: ' , context modelName
]

{ #category : #notifications }
MidasAppQuery >> updateModel: mooseModel [
	self updateTitle.
	self updateStrongFocus: mooseModel
]

{ #category : #notifications }
MidasAppQuery >> updatePreviousNext [
	btnPrev
		enabled: (context historyHasPrevious).
	btnNext enabled: (context historyHasNext)
]

{ #category : #notifications }
MidasAppQuery >> updateStrongFocus: focus [
	
	lstEntities items: focus.
	self updatePreviousNext
]

{ #category : #notifications }
MidasAppQuery >> updateWeakFocus: focus [
	lstEntities selectItem: focus
]
