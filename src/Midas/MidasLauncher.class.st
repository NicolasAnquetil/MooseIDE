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
	#classInstVars : [
		'iconTheme'
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
	^ iconTheme ifNil: [
			iconTheme := ThemeIcons new
								name: 'icons64';
								loadIconsFromUrl ;
								yourself
			]
]

{ #category : #specs }
MidasLauncher class >> openDefault [
	<example>
	^self openOnModel: MooseModel root allModels first
]

{ #category : #specs }
MidasLauncher class >> openOnModel: aMooseModel [
	^self new openOnModel: aMooseModel
]

{ #category : #initialization }
MidasLauncher class >> resetIconTheme [
	iconTheme := nil
]

{ #category : #apps }
MidasLauncher >> exit [
	context exit.
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
			{ #models -> #launchModelsApp .
			  #metrics -> #launchDashboardApp .
			  #tasks -> #nullLaunchApp .
			  #query -> #launchQueryApp .
			  #navigate -> #launchNavigateApp .
			  #code -> #launchEditorApp .
			  #views -> #launchSystemComplexityApp .
			  #archi -> #nullLaunchApp .
			  #critic -> #nullLaunchApp .
			  #tags -> #nullLaunchApp .
			  #log -> #nullLaunchApp .
			  #exit -> #exit 
			 }
			do: [ :appDesc |
				group addItem: [ :item | 
					self
						newMenuItem: item
						named: appDesc key
						withAction: [ self perform: appDesc value ]
				]
			]
		]

]

{ #category : #initialization }
MidasLauncher >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 936 @ 120.
]

{ #category : #apps }
MidasLauncher >> launch: appPresenterClass withContext: contextClass [
	| app |
	app := self instantiate: appPresenterClass.
	app context: (context spawn: contextClass).
	app openWithSpec.
	^app
]

{ #category : #apps }
MidasLauncher >> launchDashboardApp [
	^self launch: MidasAppDashboard withContext: MidasContextDashboard
]

{ #category : #apps }
MidasLauncher >> launchEditorApp [
	^self launch: MidasAppEditor withContext: MidasContextEditor
]

{ #category : #apps }
MidasLauncher >> launchLogApp [
	^ApplicationWithToolbar new openWithSpec; yourself
]

{ #category : #apps }
MidasLauncher >> launchModelsApp [
	^self launch: MidasAppModels withContext: MidasContextModels
]

{ #category : #apps }
MidasLauncher >> launchNavigateApp [
	^self
		launch: MidasAppNavigate
		withContext: MidasContextNavigate
]

{ #category : #apps }
MidasLauncher >> launchQueryApp [
	context hasQuery
		ifTrue: [ ^ self ]
		ifFalse: [ ^self launch: MidasAppQuery withContext: MidasContextQuery ]
]

{ #category : #apps }
MidasLauncher >> launchSystemComplexityApp [
	^self
		launch: MidasAppSystemComplexity
		withContext: MidasContextSystemComplexity
]

{ #category : #apps }
MidasLauncher >> launchTagsApp [
	^self launch: MidasAppTag withContext: MidasContextTag
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

{ #category : #apps }
MidasLauncher >> nullLaunchApp [
]

{ #category : #api }
MidasLauncher >> openOnModel: aMooseModel [
	self openWithSpec.
	self context mooseModel: aMooseModel.
]

{ #category : #api }
MidasLauncher >> title [
	^ 'MIDAS Launcher: ' , context modelName
]

{ #category : #notifications }
MidasLauncher >> updateModel: newMooseModel [
	self updateTitle.
	lblModelName label: 'Current model: ' , context modelName
]

{ #category : #notifications }
MidasLauncher >> updateStrongFocus: newFocus [
	self shouldNotImplement 
]

{ #category : #notifications }
MidasLauncher >> updateWeakFocus: newFocus [
	self shouldNotImplement
]
