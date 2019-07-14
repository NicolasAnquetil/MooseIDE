Class {
	#name : #TestQueryApp,
	#superclass : #TestMidas,
	#instVars : [
		'queryApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestQueryApp >> loadDashboard [
	"Need to load the Dashboard to get entities information"
	launcherApp launchDashboardApp
]

{ #category : #running }
TestQueryApp >> setUp [
	super setUp.
	queryApp := launcherApp launchQueryApp
]

{ #category : #tests }
TestQueryApp >> testFilterQuery [
	queryApp mnuSelcol selectedIndex: 1.	"select #filter"
	queryApp fldQuery text: 'each name = ''Node'''.
	queryApp btnQuery performAction.
	self assert: queryApp lstEntities items size equals: 1.
	queryApp lstEntities items first selection name = 'Node'. "use '=' because name is a ByteString, not a String ?!?!"
]

{ #category : #tests }
TestQueryApp >> testFreezeContentIsNotSelected [
	| cachedItems |
	cachedItems := queryApp lstEntities items.
	queryApp freeze state: false.
	queryApp context mooseModel: models second.
	self deny: queryApp lstEntities items equals: cachedItems
]

{ #category : #tests }
TestQueryApp >> testFreezeContentIsSelected [
	| cachedItems |
	cachedItems := queryApp lstEntities items.
	queryApp freeze state: true.
	queryApp context mooseModel: models second.
	self assert: queryApp lstEntities items equals: cachedItems
]

{ #category : #tests }
TestQueryApp >> testPreviousAndNextButtons [
	| cachedModelContent cachedAllClasses |
	cachedModelContent := queryApp lstEntities items
		collect: [ :item | item selection ].
	queryApp lstEntities doubleClickAtIndex: 1.   "All model classes"
	cachedAllClasses := queryApp lstEntities items
		collect: [ :item | item selection ].
	self deny: cachedAllClasses equals: cachedModelContent.
	queryApp btnPrev performAction.
	self assert: (queryApp lstEntities items 	collect: [ :item | item selection ])equals: cachedModelContent.
	queryApp btnNext performAction.
	self assert: (queryApp lstEntities items 	collect: [ :item | item selection ])equals: cachedAllClasses
]

{ #category : #tests }
TestQueryApp >> testPreviousAndNextButtonsDisplay [
	self deny: queryApp btnPrev isEnabled.
	self deny: queryApp btnNext isEnabled.
	queryApp lstEntities doubleClickAtIndex: 1.   "All model classes"
	self assert: queryApp btnPrev isEnabled.
	self deny: queryApp btnNext isEnabled.
	queryApp btnPrev performAction.
	self deny: queryApp btnPrev isEnabled.
	self assert: queryApp btnNext isEnabled.
]

{ #category : #tests }
TestQueryApp >> testSelectClasses [
	queryApp lstEntities doubleClickAtIndex: 3.   "All model packages"
	queryApp btnClassScope performMenuActionWith: self.
	self assert: queryApp lstEntities items size equals: 6.
	queryApp lstEntities items
		do: [ :each | self assert: each selection isClass ]
]

{ #category : #tests }
TestQueryApp >> testSelectMethods [
	queryApp lstEntities doubleClickAtIndex: 1.   "All model classes"
	queryApp btnMethodScope performMenuActionWith: self.
	self assert: queryApp lstEntities items size equals: 58.
	queryApp lstEntities items do:[:each|self assert: each selection isMethod]
]

{ #category : #tests }
TestQueryApp >> testSelectPackage [
	queryApp lstEntities doubleClickAtIndex: 3.   "All model classes"
	queryApp btnPackageScope performMenuActionWith: self.
	self assert: queryApp lstEntities items size equals: 1.
	self assert: queryApp lstEntities items first selection name equals: 'LANSimulation'
]

{ #category : #tests }
TestQueryApp >> testUpdateStrongFocuslWhenTheItemIsDoubleClicked [
	| item |
	item := queryApp lstEntities items first selection.
	self deny: queryApp strongFocus equals: item.
	queryApp lstEntities doubleClickAtIndex: 1.
	self assert: queryApp strongFocus equals: item
]

{ #category : #tests }
TestQueryApp >> testUpdateWeakFocuslWhenTheItemIsSingleClicked [
	| item |
	item := queryApp lstEntities items first selection.
	self deny: queryApp weakFocus equals: item.
	queryApp lstEntities clickAtIndex: 1.
	self assert: queryApp weakFocus equals: item
]

{ #category : #tests }
TestQueryApp >> testWindowTitle [
	self
		assert: queryApp window title
		equals: 'MIDAS Query: First-lanModel'.
	launcherApp context mooseModel: models second.
	self
		assert: queryApp window title
		equals: 'MIDAS Query: Second-simpleModel'
]
