Class {
	#name : #TestDashboardApp,
	#superclass : #TestMidas,
	#instVars : [
		'dashboardApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestDashboardApp >> setUp [
	super setUp.
	dashboardApp := launcherApp launchDashboardApp.
]

{ #category : #tests }
TestDashboardApp >> testDisplayCyclomaticComplexity [
	| myMetric |
	myMetric := dashboardApp dashboardMetric: 3.
	self assert: myMetric first equals: '1.389'.
	self assert: (myMetric second endsWith: '0.0').
	self assert: (myMetric third endsWith: '2.736').
	self assert: (myMetric fourth endsWith: '2.736')
]

{ #category : #tests }
TestDashboardApp >> testDisplayEntities [
	| myMetric |
	myMetric := dashboardApp dashboardMetric: 1.
	self assert: myMetric first equals: '6.0'.
	self assert: (myMetric second endsWith: '0.0').
	self assert: (myMetric third endsWith: '1.0').
	self assert: (myMetric fourth endsWith: '1.0')
]

{ #category : #tests }
TestDashboardApp >> testDisplayLinesOfCode [
		| myMetric |
	myMetric := dashboardApp dashboardMetric: 2.
	self assert: myMetric first equals: '538.0'.
	self assert: (myMetric second endsWith: '0.0').
	self assert: (myMetric third endsWith: '370.0').
	self assert: (myMetric fourth endsWith: '370.0')
]
