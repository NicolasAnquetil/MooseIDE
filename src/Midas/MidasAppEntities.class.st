"
An app to select entities from the current model
"
Class {
	#name : #MidasAppEntities,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'mnuSelcol',
		'listPresenter'
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
		add: #listPresenter;
		yourself
]

{ #category : #delegated }
MidasAppEntities >> childrenFor: anEntity [
	^ context childrenFor: anEntity
]

{ #category : #delegated }
MidasAppEntities >> clearSelection [
	listPresenter clearSelection
]

{ #category : #notifications }
MidasAppEntities >> displayFocus: aCollection [
	listPresenter displayFocus: aCollection
]

{ #category : #accessing }
MidasAppEntities >> entities [
	^context formatedMidasFocus
]

{ #category : #initialization }
MidasAppEntities >> initializeWidgets [
	self canBeFrozen.
	self focusCanBeHierarchical.

	listPresenter := self instantiate: MidasPresenterEntities
]

{ #category : #initialization }
MidasAppEntities >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: self title.
	aWindowPresenter
		whenClosedDo: [ context midasFocus: context mooseModel.
			context exit ]
]

{ #category : #delegated }
MidasAppEntities >> lstEntities [
	^ listPresenter lstEntities
]

{ #category : #accessing }
MidasAppEntities >> mnuSelcol [
	^ mnuSelcol
]

{ #category : #delegated }
MidasAppEntities >> selectPaths: paths [
	listPresenter selectPaths: paths 
]

{ #category : #delegated }
MidasAppEntities >> selectedPaths [
	^listPresenter selectedPaths
]

{ #category : #api }
MidasAppEntities >> title [
	^'Entities ''' , context modelName , ''''
]

{ #category : #delegated }
MidasAppEntities >> userSelection: aSelection [
	^context userSelection: aSelection
]
