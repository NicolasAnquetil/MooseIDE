"
Moose IDE menu. Can launch a number of apps that will work on the same model
"
Class {
	#name : #IDELauncher,
	#superclass : #AbstractSpec,
	#instVars : [
		'iconTheme',
		'menu'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #specs }
IDELauncher class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :c | c add: #menu	];
		yourself
]

{ #category : #specs }
IDELauncher class >> iconSize [
	^ 74
]

{ #category : #initialization }
IDELauncher class >> iconTheme [
	^ ThemeIcons new
		name: 'icons64';
		loadIconsFromUrl ;
		yourself
]

{ #category : #specs }
IDELauncher class >> openDefault [
	self openOnModel: MooseModel root allModels first
]

{ #category : #specs }
IDELauncher class >> openOnModel: aMooseModel [
	self new openOnModel: aMooseModel
]

{ #category : #api }
IDELauncher >> extent [
	^ (self class iconSize * 9) @ (self class iconSize + 30)
]

{ #category : #accessing }
IDELauncher >> focus: anObject [
	self context focus: anObject.
]

{ #category : #initialization }
IDELauncher >> initialize [
	"must set iconTheme before super>>initialize"
	iconTheme := self class iconTheme.
	super initialize.
	context := AppContextLauncher new.

]

{ #category : #initialization }
IDELauncher >> initializeWidgets [
	menu := MenuPresenter new
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
				addItem: [ :item | 
					self
						newMenuItem: item
						named: #tasks
						withAction: [ self launchTasksApp ] ];
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
				addItem: [ :item | self newMenuItem: item named: #views withAction: [ self launchVisualizerApp ] ];
				"addItem: [ :item | self newMenuItem: item named: #archi withAction: nil ] ;"
					addItem: [ :item | self newMenuItem: item named: #critic withAction: nil ];
				addItem: [ :item | self newMenuItem: item named: #tags withAction: nil ];
				addItem:
						[ :item | self newMenuItem: item named: #log withAction: [ self launchLogApp ] ] ]
]

{ #category : #apps }
IDELauncher >> launch: appPresenterClass withContext: contextClass [
	| app |
	app := self instantiate: appPresenterClass.
	app context: (context spawn: contextClass).
	
	app openWithSpec.
	^app
]

{ #category : #apps }
IDELauncher >> launchDashboardApp [
	self launch: IDEDashboard withContext: AppContextDashboard 

]

{ #category : #apps }
IDELauncher >> launchEditorApp [
	self launch: IDEEditor withContext: AppContextEditor

]

{ #category : #apps }
IDELauncher >> launchLogApp [
	ApplicationWithToolbar new openWithSpec
]

{ #category : #apps }
IDELauncher >> launchModelsApp [
	self inform: 'Current model: '  , context mooseModel name
]

{ #category : #apps }
IDELauncher >> launchQueryApp [
	self launch: IDEQuery withContext: AppContextQuery
]

{ #category : #apps }
IDELauncher >> launchTasksApp [
	self inform: 'Tasks resetting context listeners'.
	context resetListners
]

{ #category : #apps }
IDELauncher >> launchVisualizerApp [
	self launch: IDEVisualizer withContext: AppContextVisualizer
]

{ #category : #accessing }
IDELauncher >> menu [
	^menu
]

{ #category : #accessing }
IDELauncher >> model: aModel [
	self context focus: aModel.
	self title: aModel name
]

{ #category : #initialization }
IDELauncher >> newMenuItem: menuItem named: aSymbol withAction: aBlock [	
	| defaultActionBlock |
	defaultActionBlock := [self inform: aSymbol].
	^ menuItem
			name: nil ;
			description: aSymbol ;
			icon: (iconTheme iconNamed: aSymbol) ;
			action: (aBlock ifNil: [ defaultActionBlock ]).

]

{ #category : #api }
IDELauncher >> openOnModel: aMooseModel [
	self openWithSpec.
	self context mooseModel: aMooseModel
]

{ #category : #api }
IDELauncher >> title [
	^ 'MIDAS Launcher'
]

{ #category : #notifications }
IDELauncher >> update: uiModel [
	self title: context mooseModel name.
]
