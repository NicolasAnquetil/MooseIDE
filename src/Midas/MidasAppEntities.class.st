"
An app to select entities from the current model
"
Class {
	#name : #MidasAppEntities,
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
	#category : #'Midas-gui'
}

{ #category : #specs }
MidasAppEntities class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
				add: #chkFreeze;
				add: #chkAssociation)
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

{ #category : #accessing }
MidasAppEntities >> btnClassScope [
	^mnuScope menuGroups first menuItems second
]

{ #category : #accessing }
MidasAppEntities >> btnMethodScope [
	^mnuScope menuGroups first menuItems third
]

{ #category : #accessing }
MidasAppEntities >> btnPackageScope [
	^mnuScope menuGroups first menuItems first
]

{ #category : #accessing }
MidasAppEntities >> btnQuery [
	^ btnQuery
]

{ #category : #accessing }
MidasAppEntities >> chkAssociation [
	^ chkAssociation
]

{ #category : #accessing }
MidasAppEntities >> chkFreeze [
^chkFreeze
]

{ #category : #accessing }
MidasAppEntities >> context: aContext [
	super context: aContext.
]

{ #category : #accessing }
MidasAppEntities >> filterQuery [
	^ filterQuery
]

{ #category : #accessing }
MidasAppEntities >> fldQuery [
	^fldQuery
]

{ #category : #initialization }
MidasAppEntities >> initializePresenter [
	chkFreeze
		whenActivatedDo: [ context freeze ];
		whenDeactivatedDo: [ context unfreeze ].
	chkAssociation
		whenActivatedDo: [ context trackAssociation ];
		whenDeactivatedDo: [ context flattenResult ].
	lstEntities
		whenSelectionChangedDo: [ :selection | 
			[ :item | context userSelection: item ]
				cull: selection selectedItem ].
	mnuSelcol
		whenSelectedItemChangedDo: [ :item | filterQuery := item = #filter ]
]

{ #category : #initialization }
MidasAppEntities >> initializeWidgetListEntities [
	lstEntities := self instantiate: ListPresenter.
	lstEntities contextMenu: self listMenu.
	lstEntities
		displayBlock: [ :entity | entity displayWithParent: context resultsWithParents ];
		icons: [ :item | item mooseIcon ]";
		sortingBlock: [ :entityA :entityB | entityA lessThan: entityB ]"
]

{ #category : #initialization }
MidasAppEntities >> initializeWidgets [
	self canBeFrozen.
	chkAssociation := (self instantiate: CheckBoxPresenter)
		label: 'Result as tree';
		yourself.
	self initializeWidgetsQueryRow.
	self initializeWidgetsScopeRow.
	self initializeWidgetListEntities
]

{ #category : #initialization }
MidasAppEntities >> initializeWidgetsQueryRow [
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
MidasAppEntities >> initializeWidgetsScopeRow [
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
MidasAppEntities >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: self title.
	aWindowPresenter
		whenClosedDo: [ context midasFocus: context mooseModel.
			context exit ]
]

{ #category : #menu }
MidasAppEntities >> listMenu [
	^ self newMenu
		addItem: [ :anItem | 
			anItem
				name: 'Inspect';
				icon: (self iconNamed: #smallInspectIt);
				action: [ lstEntities selection selectedItem inspect ] ]
]

{ #category : #accessing }
MidasAppEntities >> lstEntities [
	^ lstEntities
]

{ #category : #accessing }
MidasAppEntities >> mnuScope [
	^ mnuScope
]

{ #category : #accessing }
MidasAppEntities >> mnuSelcol [
	^ mnuSelcol
]

{ #category : #running }
MidasAppEntities >> runQueryButtonAction [
	^[ context interpretQuery: fldQuery getText  ]
]

{ #category : #api }
MidasAppEntities >> title [
	^'MIDAS Query: ''' , context modelName , ''''
]

{ #category : #notifications }
MidasAppEntities >> updateMidasFocus: focus [
	lstEntities items: focus.
]
