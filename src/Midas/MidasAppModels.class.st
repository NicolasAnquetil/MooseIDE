Class {
	#name : #MidasAppModels,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'lstModels',
		'mnuLoders'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppModels class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :c | c add: #mnuLoaders height: self toolbarHeight;
								 add: #lstModels ];
		yourself
]

{ #category : #accessing }
MidasAppModels >> context: aContext [
	super context: aContext.
	lstModels items: aContext allModels
]

{ #category : #api }
MidasAppModels >> extent [
	^ 100 @ 300
]

{ #category : #'as yet unclassified' }
MidasAppModels >> importMSEModel [
	context mooseModel: MVSMSELoader importModel
]

{ #category : #'as yet unclassified' }
MidasAppModels >> importStModel [
	context mooseModel: MPImportSTCommand new execute
]

{ #category : #initialization }
MidasAppModels >> initializePresenter [
	super initializePresenter.
	lstModels
		doubleClickAction: [ :item | self context mooseModel: lstModels selectedItem ]
]

{ #category : #initialization }
MidasAppModels >> initializeWidgets [
	super initializeWidgets.
	lstModels := (self instantiate: FastTablePresenter)
		displayBlock: [ :item | item name ];
		icons: [ :item | item mooseIcon ];
		sortingBlock: [ :a :b | a name < b name ];
		yourself.
	mnuLoders := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Import model from MSE file';
						icon: MooseIcons mooseImportMse;
						action: [ self importMSEModel ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Import Smalltalk';
						icon: MooseIcons mooseImportSmalltalk;
						action: [ self importStModel ] ] ].
	mnuLoders applyTo: self.
]

{ #category : #accessing }
MidasAppModels >> lstModels [
	^ lstModels
]

{ #category : #accessing }
MidasAppModels >> mnuLoaders [
	^mnuLoders 
]

{ #category : #initialization }
MidasAppModels >> setSelectionTo: anItem [
	lstModels resetSelection.
	lstModels setSelectedItem: anItem
]

{ #category : #api }
MidasAppModels >> title [
	^'Moose models'
]

{ #category : #notifications }
MidasAppModels >> updateModel: newModel [
	lstModels items: context allModels.
	self setSelectionTo: newModel
	
]

{ #category : #notifications }
MidasAppModels >> updateStrongFocus: focus [
	self shouldNotImplement 
]

{ #category : #notifications }
MidasAppModels >> updateWeakFocus: focus [
	self shouldNotImplement
]
