"
An app to select entities from the current model
"
Class {
	#name : #MidasAppEntities,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'chkAssociation',
		'mnuSelcol',
		'lstEntities',
		'btnFocusOnSelection'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasAppEntities class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
				add: #chkFreeze;
				add: #btnFocusOnSelection ;
				add: #chkAssociation ;
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #lstEntities;
		yourself
]

{ #category : #accessing }
MidasAppEntities >> btnFocusOnSelection [
	^btnFocusOnSelection
]

{ #category : #initialization }
MidasAppEntities >> canBeFrozen [
	super canBeFrozen.

	btnFocusOnSelection := self newButton.
	btnFocusOnSelection label: 'Force focus'.
	btnFocusOnSelection enable.

	
]

{ #category : #accessing }
MidasAppEntities >> chkAssociation [
	^ chkAssociation
]

{ #category : #accessing }
MidasAppEntities >> context: aContext [
	super context: aContext.
	chkFreeze state
		ifTrue:  [ aContext freeze ];
		ifFalse: [ aContext unfreeze ]
]

{ #category : #accessing }
MidasAppEntities >> entities [
	^context formatedMidasFocus
]

{ #category : #initialization }
MidasAppEntities >> initializePresenter [
	chkFreeze
		whenActivatedDo: [ context freeze ];
		whenDeactivatedDo: [ context unfreeze ].
	btnFocusOnSelection action: [ context focusOnSelection ].
	chkAssociation
		whenActivatedDo: [ context trackAssociation ];
		whenDeactivatedDo: [ context flattenResult ].
	lstEntities
		whenSelectionChangedDo: [ :selection | 
			context userSelection: selection selectedPaths ].

]

{ #category : #initialization }
MidasAppEntities >> initializeWidgetListEntities [
	lstEntities 	:= self newTreeTable.
	lstEntities
		beMultipleSelection ;
		addColumn: (StringTableColumn new
							evaluated: #name;
							yourself) ;
		children: [ :each | self context childrenFor: each ]

]

{ #category : #initialization }
MidasAppEntities >> initializeWidgets [
	self canBeFrozen.
	
	chkAssociation := (self instantiate: CheckBoxPresenter)
		label: 'Result as tree';
		yourself.
	self initializeWidgetListEntities
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
				action: [ lstEntities entities selectedItem inspect ] ]
]

{ #category : #accessing }
MidasAppEntities >> lstEntities [
	^ lstEntities
]

{ #category : #accessing }
MidasAppEntities >> mnuSelcol [
	^ mnuSelcol
]

{ #category : #api }
MidasAppEntities >> title [
	^'Entities ''' , context modelName , ''''
]

{ #category : #notifications }
MidasAppEntities >> updateMidasFocus: aCollection [
	lstEntities roots: aCollection
]

{ #category : #notifications }
MidasAppEntities >> updateModel: entity [
	super updateModel: entity.
	self updateMidasFocus: entity
]
