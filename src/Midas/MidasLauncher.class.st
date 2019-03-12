"
Moose IDE menu. Can launch a number of apps that will work on the same model
"
Class {
	#name : #MidasLauncher,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'iconTheme',
		'menu'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasLauncher class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :c | c add: #menu	];
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
	self openOnModel: MooseModel root allModels first
]

{ #category : #specs }
MidasLauncher class >> openOnModel: aMooseModel [
	self new openOnModel: aMooseModel
]

{ #category : #api }
MidasLauncher >> extent [
	^ (self class iconSize * 9) @ (self class iconSize + 30)
]

{ #category : #accessing }
MidasLauncher >> focus: anObject [
	self context focus: anObject.
]

{ #category : #initialization }
MidasLauncher >> initialize [
	"must set iconTheme before super>>initialize"

	iconTheme := self class iconTheme.
	context := MidasContextLauncher new.
	 super initialize
]

{ #category : #initialization }
MidasLauncher >> initializeWidgets [
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
						withAction: nil ];
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
						[ :item | self newMenuItem: item named: #log withAction: [ self launchLogApp ] ] ]
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
	self inform: 'Current model: ' , self mooseModel name
]

{ #category : #apps }
MidasLauncher >> launchQueryApp [
	self launch: MidasAppQuery withContext: MidasChildContext
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

{ #category : #accessing }
MidasLauncher >> menu [
	^menu
]

{ #category : #accessing }
MidasLauncher >> model: aModel [
	self context focus: aModel.
	self title: aModel name
]

{ #category : #initialization }
MidasLauncher >> newMenuItem: menuItem named: aSymbol withAction: aBlock [	
	| defaultActionBlock |
	defaultActionBlock := [self inform: aSymbol].
	^ menuItem
			name: nil ;
			description: aSymbol ;
			icon: (iconTheme iconNamed: aSymbol) ;
			action: (aBlock ifNil: [ defaultActionBlock ]).

]

{ #category : #api }
MidasLauncher >> openOnModel: aMooseModel [
	self openWithSpec.
	self context mooseModel: aMooseModel
]

{ #category : #api }
MidasLauncher >> title [
	^ 'MIDAS Launcher'
]

{ #category : #notifications }
MidasLauncher >> updateStrongFocus: newFocus [
	self shouldNotImplement 
]

{ #category : #notifications }
MidasLauncher >> updateWeakFocus: newFocus [
	self shouldNotImplement
]
