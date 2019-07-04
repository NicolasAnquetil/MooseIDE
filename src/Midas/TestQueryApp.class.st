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
