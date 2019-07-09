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
	self loadDashboard.
	queryApp := launcherApp launchQueryApp
]

{ #category : #tests }
TestQueryApp >> testFilterQuery [
	queryApp mnuSelcol selectedIndex: 1.	"select #filter"
	queryApp fldQuery text: 'each name = ''Node'''.
	queryApp btnQuery performAction.
	queryApp lstEntities items
		do: [ :item | self assert: item selection name equals: 'Node' ]
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
	queryApp lstEntities doubleClickAtIndex: 1.
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
	queryApp lstEntities doubleClickAtIndex: 1.
	self assert: queryApp btnPrev isEnabled.
	self deny: queryApp btnNext isEnabled.
	queryApp btnPrev performAction.
	self deny: queryApp btnPrev isEnabled.
	self assert: queryApp btnNext isEnabled.
]

{ #category : #tests }
TestQueryApp >> testSelectClasses [
	| classesItem |
	queryApp lstEntities doubleClickAtIndex: 1.
	classesItem := queryApp mnuScope menuGroups first menuItems second.
	classesItem performMenuActionWith: self.
	queryApp lstEntities items
		do: [ :each | self assert: each selection isClass ]
]

{ #category : #tests }
TestQueryApp >> testSelectMethods [
	| methodsItem |
	queryApp lstEntities doubleClickAtIndex: 1.
	methodsItem := queryApp mnuScope menuGroups first menuItems third.
	methodsItem performMenuActionWith: self.
	queryApp lstEntities items do:[:each|self assert: each selection isMethod]
]

{ #category : #tests }
TestQueryApp >> testSelectPackage [
	| packageItem |
	queryApp lstEntities doubleClickAtIndex: 1.
	packageItem := queryApp mnuScope menuGroups first menuItems first.
	packageItem performMenuActionWith: self.
	queryApp lstEntities items
		do: [ :each | self assert: each selection isPackage ]
]
