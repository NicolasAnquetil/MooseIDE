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

{ #category : #initialization }
MidasAppNavigate >> initializeWidgetsQueryRow [
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
MidasAppNavigate >> initializeWidgetsScopeRow [
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

{ #category : #accessing }
MidasAppNavigate >> lstProperties [
	^ lstProperties
]

{ #category : #refreshing }
MidasAppNavigate >> refresh [
	lstProperties items: context navigationProperties 
]

{ #category : #running }
MidasAppNavigate >> runQueryButtonAction [
	^[ context interpretQuery: fldQuery getText  ]
]

{ #category : #accessing }
MidasAppNavigate >> selectedItems [
	^ lstProperties selectedItems
]

{ #category : #TOREMOVE }
MidasAppNavigate >> title [
	^'Navigate ''' , context modelName , ''''
]

{ #category : #notifications }
MidasAppNavigate >> updateMidasFocus: focus [
	self refresh.
	self clearSelection
]
