"
Moose IDE menu. Can launch a number of apps that will work on the same model
"
Class {
	#name : #MidasLauncher,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'iconTheme',
		'menu',
		'lblModelName',
		'appModels',
		'appDashboard',
		'appEntities',
		'appQuery',
		'appCode',
		'appView',
		'appHistory',
		'appExit'
	],
	#classInstVars : [
		'iconTheme'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasLauncher class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #lblModelName
			withConstraints: [ :constraints | constraints height: 20 ];
		add: (SpBoxLayout newHorizontal
					add: #appModels ;
					add: #appDashboard ;
					add: #appEntities ;
					add: #appQuery ;
					add: #appCode ;
					add: #appView ;
					add: #appHistory ;
					add: #appExit ;
					yourself
				) ;
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
MidasLauncher class >> open [
	<script>
	^self new
		openWithSpec ;
		yourself
]

{ #category : #specs }
MidasLauncher class >> openDefault [
	<script>
	| launcher |
	launcher := self openOnModel: MooseModel root allModels first.
	launcher launchEntitiesApp.
	launcher launchQueryApp.
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

{ #category : #initialization }
MidasLauncher >> appIcon: appDesc [
	^ appDesc value = #nullLaunchApp
		ifTrue: [ appDesc key asString , '-off' ]
		ifFalse: [ appDesc key ]
]

{ #category : #initialization }
MidasLauncher >> defaultApps [
	^ {
	(#models -> #launchModelsApp).
	(#metrics -> #launchDashboardApp).
	(#entities -> #launchEntitiesApp).
	(#query -> #launchQueryApp).
	(#code -> #launchEditorApp).
	(#views -> #launchSystemComplexityApp).
	(#archi -> #nullLaunchApp).
	(#critic -> #nullLaunchApp).
	(#tags -> #nullLaunchApp).
	(#tasks -> #nullLaunchApp).
	(#history -> #launchHistoryApp).
	(#exit -> #exit)
	}
]

{ #category : #initialization }
MidasLauncher >> disableWithoutModel: menuItem [
	(#(models exit) includes: menuItem description) 
		ifFalse: [ menuItem enabled: false ].
]

{ #category : #notifications }
MidasLauncher >> displayFocus: newFocus [
	"nothing"
]

{ #category : #notifications }
MidasLauncher >> displayModel: aMooseModel [
	super displayModel: aMooseModel.
	lblModelName label: 'Current model: ''' , context modelName , ''''.
	self enableWithModel 
]

{ #category : #initialization }
MidasLauncher >> enableButton: itemName [
	^ (#(models exit) includes: itemName) or: [ context mooseModel notNil ].
]

{ #category : #initialization }
MidasLauncher >> enableWithModel [
	"menu menuGroups first menuItems do: [ :item | item enable ]"
	appModels    enabled: (self enableButton: #models).
	appDashboard enabled: (self enableButton: #metrics).
	appEntities  enabled: (self enableButton: #entities).
	appQuery     enabled: (self enableButton: #query).
	appCode      enabled: (self enableButton: #code).
	appView      enabled: (self enableButton: #views).
	appHistory   enabled: (self enableButton: #history).
	appExit      enabled: (self enableButton: #exit).

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
	"menu := self newMenuBar
		addGroup: [ :group | 
			self defaultApps do: [ :appDesc | 
				group addItem: [ :item || icon |
					icon := self appIcon: appDesc.
					self
						newMenuItem: item
						named: icon
						withAction: [ self perform: appDesc value ]
				]
			]
		]"
	appModels   := self newButton: #models action: #launchModelsApp.
	appDashboard:= self newButton: #metrics action: #launchDashboardApp.
	appEntities := self newButton: #entities action: #launchEntitiesApp.
	appQuery    := self newButton: #query action: #launchQueryApp.
	appCode     := self newButton: #code action: #launchEditorApp.
	appView     := self newButton: #views action: #launchSystemComplexityApp.
	appHistory  := self newButton: #history action: #launchHistoryApp.
	appExit     := self newButton: #exit action: #exit.

]

{ #category : #initialization }
MidasLauncher >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 670 @ 120.
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
	^self launch: MidasAppEntities withContext: MidasContextEntities
]

{ #category : #apps }
MidasLauncher >> launchHistoryApp [
	^self
		launch: MidasAppHistory
		withContext: MidasContextHistory
]

{ #category : #apps }
MidasLauncher >> launchModelsApp [
	^self launch: MidasAppModels withContext: MidasContextModels
]

{ #category : #apps }
MidasLauncher >> launchQueryApp [
	^self
		launch: MidasAppQuery
		withContext: MidasContextQuery
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

{ #category : #accessing }
MidasLauncher >> menu [
	^menu
]

{ #category : #initialization }
MidasLauncher >> newButton: nameSymbol action: actionSymbol [
	^self newButton
		icon: (iconTheme iconNamed: nameSymbol);
		action: [ self perform: actionSymbol ];
		enabled: (self enableButton: nameSymbol)
		yourself
	
]

{ #category : #initialization }
MidasLauncher >> newMenuItem: menuItem named: aSymbol withAction: aBlock [
	| defaultActionBlock |
	defaultActionBlock := [ self inform: aSymbol ].
	menuItem
		description: aSymbol;
		icon: (iconTheme iconNamed: aSymbol);
		action: (aBlock ifNil: [ defaultActionBlock ]).

	context mooseModel
		ifNil: [ self disableWithoutModel: menuItem ].
	^ menuItem

]

{ #category : #apps }
MidasLauncher >> nullLaunchApp [
	UIManager default inform: 'This app was not implemented yet'
]

{ #category : #api }
MidasLauncher >> openOnModel: aMooseModel [
	self openWithSpec.
	self context initializeMooseModel: aMooseModel.
]

{ #category : #api }
MidasLauncher >> title [
	^ 'MIDAS ''' , context modelName , ''''
]
