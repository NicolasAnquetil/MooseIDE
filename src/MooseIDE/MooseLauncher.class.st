Class {
	#name : #MooseLauncher,
	#superclass : #AbstractSpec,
	#instVars : [
		'iconTheme',
		'menu'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #specs }
MooseLauncher class >> defaultSpec [

	^ SpecLayout composed
		newColumn: [ :c | 
			c 
				add: #menu height: self iconSize ];
		yourself
]

{ #category : #specs }
MooseLauncher class >> iconSize [
	^ 64 + 5
]

{ #category : #initialization }
MooseLauncher class >> iconTheme [
	^ ThemeIcons new
		name: 'icons64';
		loadIconsFromUrl ;
		yourself
]

{ #category : #'as yet unclassified' }
MooseLauncher class >> openDefault [
	self openOnModel: MooseModel root allModels first
]

{ #category : #'as yet unclassified' }
MooseLauncher class >> openOnModel: aMooseModel [
	self new openOnModel: aMooseModel
]

{ #category : #accessing }
MooseLauncher >> focus: anObject [
	self context focus: anObject.
]

{ #category : #initialization }
MooseLauncher >> initialize [
	"must set iconTheme before super>>initialize"
	iconTheme := self class iconTheme.
	super initialize.
	context := AppContextLauncher new.

]

{ #category : #initialization }
MooseLauncher >> initializeWidgets [
	menu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | self newMenuItem: item named: #models withAction: [ self inform: 'Current model: '  , context mooseModel name ] ] ;
				addItem: [ :item | self newMenuItem: item named: #metrics withAction: [ self launchDashboard ] ] ;
				addItem: [ :item | self newMenuItem: item named: #tasks withAction: nil ] ;
				addItem: [ :item | self newMenuItem: item named: #query withAction: [ self launchQueryTool ] ] ;
				addItem: [ :item | self newMenuItem: item named: #code withAction: [ self launchEditorTool ] ] ;
				addItem: [ :item | self newMenuItem: item named: #views withAction: nil ] ;
				"addItem: [ :item | self newMenuItem: item named: #archi withAction: nil ] ;"
				addItem: [ :item | self newMenuItem: item named: #critic withAction: nil ] ;
				addItem: [ :item | self newMenuItem: item named: #tags withAction: nil ] ;
				addItem: [ :item | self newMenuItem: item named: #log withAction: [  ApplicationWithToolbar new openWithSpec ] ]
		].

]

{ #category : #apps }
MooseLauncher >> launchDashboard [
	| board |
	board := self instantiate: IDEDashboard.
	board context: (context spawn: AppContextDashboard).
	
	board openWithSpec
]

{ #category : #initialization }
MooseLauncher >> launchEditorTool [
	| editor |
	editor := self instantiate: IDEEditor.
	editor context: (context spawn: AppContextEditor).
	
	editor openWithSpec
]

{ #category : #apps }
MooseLauncher >> launchQueryTool [

]

{ #category : #accessing }
MooseLauncher >> menu [
	^menu
]

{ #category : #accessing }
MooseLauncher >> model: aModel [
	self context focus: aModel.
	self title: aModel name
]

{ #category : #initialization }
MooseLauncher >> newMenuItem: menuItem named: aSymbol withAction: aBlock [	
	| defaultActionBlock |
	defaultActionBlock := [self inform: aSymbol].
	^ menuItem
			name: nil ;
			description: aSymbol ;
			icon: (iconTheme iconNamed: aSymbol) ;
			action: (aBlock ifNil: [ defaultActionBlock ]).

]

{ #category : #api }
MooseLauncher >> openOnModel: aMooseModel [
	self openWithSpec.
	self context mooseModel: aMooseModel 
]

{ #category : #notifications }
MooseLauncher >> update: uiModel [
	self title: context mooseModel name.
]
