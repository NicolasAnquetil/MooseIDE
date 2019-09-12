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
	#category : #'Midas-gui'
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
	<script>
	| launcher |
	launcher := self openOnModel: MooseModel root allModels first.
	launcher launchEntitiesApp.
	launcher launchNavigateApp.
	^ launcher
]

{ #category : #specs }
MidasLauncher class >> openOnModel: aMooseModel [
	^self new openOnModel: aMooseModel
]

{ #category : #initialization }
MidasLauncher class >> resetIconTheme [
	<script>
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
			  #query -> #launchEntitiesApp .
			  #navigate -> #launchNavigateApp .
			  #code -> #launchEditorApp .
			  #views -> #nullLaunchApp .
			  #archi -> #nullLaunchApp .
			  #critic -> #nullLaunchApp .
			  #tags -> #nullLaunchApp .
			  #tasks -> #nullLaunchApp .
			  #log -> #launchHistoryApp .
			  #exit -> #exit 
			 }
			do: [ :appDesc |
				group addItem: [ :item || icon |
					icon := (appDesc value = #nullLaunchApp) ifTrue: [ appDesc key asString , '-off' ] ifFalse: [ appDesc key ].
					self
						newMenuItem: item
						named: icon
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
MidasLauncher >> launchEntitiesApp [
	context hasEntities
		ifTrue: [ ^ self ]
		ifFalse: [ ^self launch: MidasAppEntities withContext: MidasContextEntities ]
]

{ #category : #apps }
MidasLauncher >> launchHistoryApp [
	^self
		launch: MidasAppHistory
		withContext: MidasContextHistory
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
	UIManager default inform: 'This app was not implemented yet'
]

{ #category : #api }
MidasLauncher >> openOnModel: aMooseModel [
	self openWithSpec.
	self context mooseModel: aMooseModel.
]

{ #category : #api }
MidasLauncher >> title [
	^ 'MIDAS Launcher: ''' , context modelName , ''''
]

{ #category : #notifications }
MidasLauncher >> updateMidasFocus: newFocus [
	self shouldNotImplement 
]

{ #category : #notifications }
MidasLauncher >> updateModel: aMooseModel [
	super updateModel: aMooseModel.
	lblModelName label: 'Current model: ''' , context modelName , ''''
]
