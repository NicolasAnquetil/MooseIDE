"
An app responsible for managing MooseModels: creating new one, loading or selecting them.
"
Class {
	#name : #MidasAppModels,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'lstModels',
		'mnuLoaders'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasAppModels class >> defaultSpec [
	^ SpBoxLayout newVertical
		"add: #mnuLoaders
			withConstraints: [ :constraints | constraints height: self toolbarHeight ] ;"
		add: #lstModels;
		yourself
]

{ #category : #api }
MidasAppModels >> clearSelection [
	lstModels unselectAll
]

{ #category : #accessing }
MidasAppModels >> context: aContext [
	super context: aContext.
	lstModels items: aContext allModels
]

{ #category : #import }
MidasAppModels >> importMSEModel [
	context mooseModel: (MVSMSELoader importModel ifNil:[^self]).
]

{ #category : #import }
MidasAppModels >> importStModel [
	context mooseModel: (MPImportSTCommand new execute ifNil:[^self])
]

{ #category : #initialization }
MidasAppModels >> initializePresenter [

	lstModels whenSelectionChangedDo: [ :selection |
		selection selectedIndex ifNotNil: [ :i | context userSelection: i ]
	]

]

{ #category : #initialization }
MidasAppModels >> initializeWidgets [
	lstModels := self newList
		display: [ :item | item name ];
		icons: [ :item | item mooseIcon ];
		sortingBlock: [ :a :b | a name < b name ];
		yourself.
	"mnuLoaders := self newMenuBar
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						description: 'Import model from MSE file';
						icon: MooseIcons mooseImportMse;
						action: [ self importMSEModel ] ].
			group
				addItem: [ :item | 
					item
						description: 'Import Smalltalk';
						icon: MooseIcons mooseImportSmalltalk;
						action: [ self importStModel ] ] ].
	mnuLoaders applyTo: self"
]

{ #category : #initialization }
MidasAppModels >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 230 @ 300.
]

{ #category : #accessing }
MidasAppModels >> lstModels [
^lstModels
]

{ #category : #accessing }
MidasAppModels >> mnuLoaders [
	^ mnuLoaders
]

{ #category : #refreshing }
MidasAppModels >> refresh [
	lstModels items: context allModels
]

{ #category : #accessing }
MidasAppModels >> selectedIndexes [
	^ lstModels selection selectedIndexes
]

{ #category : #api }
MidasAppModels >> title [
	^'Moose models'
]

{ #category : #notifications }
MidasAppModels >> updateModel: newModel [
	self clearSelection 
	
]
