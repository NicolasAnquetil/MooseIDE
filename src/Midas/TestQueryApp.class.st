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
TestQueryApp >> testFreezeContentCheckbox [
	| cachedStrongFocus |
	cachedStrongFocus := queryApp context strongFocus.
	"freeze"
	queryApp freeze state: true.
	self assert: queryApp context frozen.
	queryApp lstEntities doubleClickAtIndex: 1.
	self assert: queryApp context strongFocus equals: cachedStrongFocus.
	
	"unfreeze"
	queryApp freeze state: false.
	self deny: queryApp context frozen.
	queryApp lstEntities doubleClickAtIndex: 1.
	self deny: queryApp context strongFocus equals: cachedStrongFocus.
	self assert: queryApp btnPrev isEnabled.
	
	"freeze"
	queryApp freeze state: true.
	self deny: queryApp btnPrev isEnabled
]
