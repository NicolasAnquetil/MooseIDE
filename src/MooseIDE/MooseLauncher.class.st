Class {
	#name : #MooseLauncher,
	#superclass : #AbstractSpec,
	#instVars : [
		'model',
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
	self openOnModel: StubModel new
]

{ #category : #'as yet unclassified' }
MooseLauncher class >> openOnModel: aModel [
	self new
		model: aModel ;
		openWithSpec
]

{ #category : #initialization }
MooseLauncher >> initialize [
	"must set iconTheme before super>>initialize"
	iconTheme := self class iconTheme.
	super initialize.
	context := LauncherContext new
]

{ #category : #initialization }
MooseLauncher >> initializeWidgets [
	menu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | self newMenuItem: item named: #models withAction: nil ] ;
				addItem: [ :item | self newMenuItem: item named: #metrics withAction: nil ] ;
				addItem: [ :item | self newMenuItem: item named: #tasks withAction: nil ] ;
				addItem: [ :item | self newMenuItem: item named: #query withAction: [ self launch: QueryTool on: nil ] ] ;
				addItem: [ :item | self newMenuItem: item named: #code withAction: [   ApplicationWithToolbar new openWithSpec ] ] ;
				addItem: [ :item | self newMenuItem: item named: #views withAction: nil ] ;
				"addItem: [ :item | self newMenuItem: item named: #archi withAction: nil ] ;"
				addItem: [ :item | self newMenuItem: item named: #critic withAction: nil ] ;
				addItem: [ :item | self newMenuItem: item named: #tags withAction: nil ] ;
				addItem: [ :item | self newMenuItem: item named: #log withAction: [  ApplicationWithToolbar new openWithSpec ] ]
		].

]

{ #category : #accessing }
MooseLauncher >> menu [
	^menu
]

{ #category : #accessing }
MooseLauncher >> model [
	^ model
]

{ #category : #accessing }
MooseLauncher >> model: aModel [
	self context currentGroup: aModel.
	self title: aModel name
]

{ #category : #initialization }
MooseLauncher >> newMenuItem: menuItem named: aSymbol withAction: aBlock [	
	| defaultAction |
	defaultAction := [self inform: aSymbol].
	^ menuItem
			name: nil ;
			description: aSymbol ;
			icon: (iconTheme iconNamed: aSymbol) ;
			action: (aBlock ifNil: [defaultAction]).

]
