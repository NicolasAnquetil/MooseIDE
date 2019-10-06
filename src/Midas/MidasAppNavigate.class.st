"
An app showing navigation links from the current focus
"
Class {
	#name : #MidasAppNavigate,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'properties'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasAppNavigate class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #properties ;
		yourself
]

{ #category : #initialization }
MidasAppNavigate >> initializePresenter [ 
	"-- Not using the 'freeze' checkbox --
	 super initializePresenter."
	properties whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [ :item | context userSelection: item ]
	]
	

]

{ #category : #initialization }
MidasAppNavigate >> initializeWidgets [
	properties := self newList.
	properties
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
MidasAppNavigate >> properties [
	^ properties
]

{ #category : #refreshing }
MidasAppNavigate >> refresh [
	properties items: context navigationProperties 
]

{ #category : #running }
MidasAppNavigate >> runQueryButtonAction [
	^[ context interpretQuery: fldQuery getText  ]
]

{ #category : #TOREMOVE }
MidasAppNavigate >> title [
	^'Navigate ''' , context modelName , ''''
]

{ #category : #notifications }
MidasAppNavigate >> updateMidasFocus: focus [
	self refresh
]
