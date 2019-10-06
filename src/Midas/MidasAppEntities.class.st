"
An app to select entities from the current model
"
Class {
	#name : #MidasAppEntities,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'mnuSelcol',
		'lstEntities'
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
				add: #chkHierarchicalFocus ;
				yourself)
		withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #lstEntities;
		yourself
]

{ #category : #accessing }
MidasAppEntities >> entities [
	^context formatedMidasFocus
]

{ #category : #initialization }
MidasAppEntities >> initializePresenter [
	super initializePresenter.
	lstEntities
		whenSelectionChangedDo: [ :selection | 
			context userSelection: selection selectedPaths ].

]

{ #category : #initialization }
MidasAppEntities >> initializeWidgets [
	self canBeFrozen.
	self focusCanBeHierarchical.

	lstEntities 	:= self newTreeTable.
	lstEntities
		beMultipleSelection ;
		addColumn: (StringTableColumn new
							evaluated: #name;
							yourself) ;
		children: [ :each | self context childrenFor: each ]

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
