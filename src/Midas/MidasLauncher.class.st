"
Moose IDE menu. Can launch a number of apps that will work on the same model
"
Class {
	#name : #MidasLauncher,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'iconTheme',
		'menu',
		'lblModelName'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasLauncher class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #lblModelName
			withConstraints: [ :constraints | constraints height: 20 ];
		add: #menu;
		yourself
]

{ #category : #specs }
MidasLauncher class >> iconSize [
	^ 74
]

{ #category : #initialization }
MidasLauncher class >> iconTheme [
	^ ThemeIcons new
		name: 'icons64';
		loadIconsFromUrl ;
		yourself
]

{ #category : #specs }
MidasLauncher class >> openDefault [
<example>
	self openOnModel: MooseModel root allModels first
]

{ #category : #specs }
MidasLauncher class >> openOnModel: aMooseModel [
	self new openOnModel: aMooseModel
]

{ #category : #apps }
MidasLauncher >> exit [
	context exit.
]

{ #category : #accessing }
MidasLauncher >> focus: anObject [
	self flag: #remove.
	self context focus: anObject
]

{ #category : #initialization }
MidasLauncher >> initialize [
	"must set iconTheme before super>>initialize"

	iconTheme := self class iconTheme.
	self context: MidasContextLauncher new.
	super initialize
]

{ #category : #initialization }
MidasLauncher >> initializePresenter [
	"voiding MidasAbstractApp>>initializePresenter"
]

{ #category : #initialization }
MidasLauncher >> initializeWidgets [
	lblModelName := self newLabel
		label: 'Current model: --';
		yourself.
	menu := self newMenuBar
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					self
						newMenuItem: item
						named: #models
						withAction: [ self launchModelsApp ] ];
				addItem: [ :item | 
					self
						newMenuItem: item
						named: #metrics
						withAction: [ self launchDashboardApp ] ];
				addItem: [ :item | self newMenuItem: item named: #tasks withAction: nil ];
				addItem: [ :item | 
					self
						newMenuItem: item
						named: #query
						withAction: [ self launchQueryApp ] ];
				addItem: [ :item | 
					self
						newMenuItem: item
						named: #code
						withAction: [ self launchEditorApp ] ];
				addItem: [ :item | 
					self
						newMenuItem: item
						named: #views
						withAction: [ self launchSystemComplexityApp ] ];
				"addItem: [ :item | self newMenuItem: item named: #archi withAction: nil ] ;"
					addItem: [ :item | self newMenuItem: item named: #critic withAction: nil ];
				addItem:
						[ :item | self newMenuItem: item named: #tags withAction: [ self launchTagsApp ] ];
				addItem:
						[ :item | self newMenuItem: item named: #log withAction: [ self launchLogApp ] ];
				addItem:
						[ :item | self newMenuItem: item named: #exit withAction: [ self exit ] ] ]
]

{ #category : #initialization }
MidasLauncher >> initializeWindow: aWindowPresenter [
	aWindowPresenter initialExtent: 780 @ 120.
	aWindowPresenter title: self title
]

{ #category : #apps }
MidasLauncher >> launch: appPresenterClass withContext: contextClass [
	| app |
	app := self instantiate: appPresenterClass.
	app context: (context spawn: contextClass).
	app openWithSpec.
]

{ #category : #apps }
MidasLauncher >> launchDashboardApp [
	self launch: MidasAppDashboard withContext: MidasContextDashboard
]

{ #category : #apps }
MidasLauncher >> launchEditorApp [
	self launch: MidasAppEditor withContext: MidasContextEditor

]

{ #category : #apps }
MidasLauncher >> launchLogApp [
	ApplicationWithToolbar new openWithSpec
]

{ #category : #apps }
MidasLauncher >> launchModelsApp [
	self launch: MidasAppModels withContext: MidasContextModels
]

{ #category : #apps }
MidasLauncher >> launchQueryApp [
	context hasQuery
		ifTrue: [ ^ self ]
		ifFalse: [ self launch: MidasAppQuery withContext: MidasContextQuery ]
]

{ #category : #apps }
MidasLauncher >> launchSystemComplexityApp [
	self
		launch: MidasAppSystemComplexity
		withContext: MidasContextSystemComplexity 
]

{ #category : #apps }
MidasLauncher >> launchTagsApp [
	self launch: MidasAppTag withContext: MidasContextTag
]

{ #category : #initialization }
MidasLauncher >> newMenuItem: menuItem named: aSymbol withAction: aBlock [
	| defaultActionBlock |
	defaultActionBlock := [ self inform: aSymbol ].
	^ menuItem
		description: aSymbol;
		icon: (iconTheme iconNamed: aSymbol);
		action: (aBlock ifNil: [ defaultActionBlock ])

]

{ #category : #api }
MidasLauncher >> openOnModel: aMooseModel [
	self openWithSpec.
	self context mooseModel: aMooseModel.
]

{ #category : #api }
MidasLauncher >> title [
	^ 'MIDAS Launcher'
]

{ #category : #notifications }
MidasLauncher >> updateModel: newMooseModel [
	self window title: newMooseModel name.
	lblModelName label: 'Current model: ' , newMooseModel name
]

{ #category : #notifications }
MidasLauncher >> updateStrongFocus: newFocus [
	self shouldNotImplement 
]

{ #category : #notifications }
MidasLauncher >> updateWeakFocus: newFocus [
	self shouldNotImplement
]
