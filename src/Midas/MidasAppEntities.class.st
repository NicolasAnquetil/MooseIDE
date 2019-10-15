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
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #chkFreeze;
				add: #btnBypassFreeze ;
				add: #chkHierarchicalFocus ;
				yourself)
		withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #lstEntities;
		yourself
]

{ #category : #api }
MidasAppEntities >> clearSelection [
	lstEntities unselectAll
]

{ #category : #notifications }
MidasAppEntities >> displayFocus: aCollection [
	lstEntities roots: aCollection.
	self clearSelection
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
			context userSelection: selection selectedPaths
		].

]

{ #category : #initialization }
MidasAppEntities >> initializeWidgets [
	self canBeFrozen.
	self focusCanBeHierarchical.

	lstEntities 	:= self newTreeTable.
	lstEntities
		beMultipleSelection ;
		addColumn: (SpStringTableColumn new
							evaluated: #midasDisplayString ;
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

{ #category : #notifications }
MidasAppEntities >> selectPaths: paths [
	lstEntities selectPaths: paths 
]

{ #category : #accessing }
MidasAppEntities >> selectedPaths [
	^lstEntities selection selectedPaths
]

{ #category : #api }
MidasAppEntities >> title [
	^'Entities ''' , context modelName , ''''
]
