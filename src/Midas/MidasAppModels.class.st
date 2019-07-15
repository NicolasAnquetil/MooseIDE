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
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppModels class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #mnuLoaders
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #lstModels;
		yourself
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

	lstModels
		doubleClickAction:
			[ :item | self context mooseModel: lstModels selection selectedItem ]
]

{ #category : #initialization }
MidasAppModels >> initializeWidgets [
	lstModels := (self instantiate: ListPresenter)
		displayBlock: [ :item | item name ];
		icons: [ :item | item mooseIcon ];
		sortingBlock: [ :a :b | a name < b name ];
		contextMenu: self listMenu;		yourself.
	mnuLoaders := self newMenuBar
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
	mnuLoaders applyTo: self
]

{ #category : #initialization }
MidasAppModels >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 230 @ 300.
]

{ #category : #menu }
MidasAppModels >> listMenu [
	^ self newMenu
		addItem: [ :anItem | 
			anItem
				name: 'Inspect';
				icon: (self iconNamed: #smallInspectIt);
				action: [ lstModels selection selectedItem inspect ] ]
]

{ #category : #accessing }
MidasAppModels >> lstModels [
^lstModels
]

{ #category : #accessing }
MidasAppModels >> mnuLoaders [
	^ mnuLoaders
]

{ #category : #api }
MidasAppModels >> title [
	^'Moose models'
]

{ #category : #notifications }
MidasAppModels >> updateModel: newModel [
	lstModels items: context allModels.
	lstModels selectItem: newModel
	
]

{ #category : #notifications }
MidasAppModels >> updateStrongFocus: focus [
	self shouldNotImplement 
]

{ #category : #notifications }
MidasAppModels >> updateWeakFocus: focus [
	self shouldNotImplement
]
