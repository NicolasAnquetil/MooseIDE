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

{ #category : #tests }
TestDashboardApp >> testFreezeContentIsNotSelected [
	| cachedMetric |
	cachedMetric := dashboardApp dashboardMetric: 1.
	dashboardApp freeze state: false.
	dashboardApp context mooseModel: models second.
	self deny: (dashboardApp dashboardMetric: 1) equals: cachedMetric
]

{ #category : #tests }
TestDashboardApp >> testFreezeContentIsSelected [
	| cachedMetric |
	cachedMetric := dashboardApp dashboardMetric: 1.
	dashboardApp freeze state: true.
	dashboardApp context mooseModel: models second.
	self assert: (dashboardApp dashboardMetric: 1) equals: cachedMetric
]

{ #category : #tests }
TestDashboardApp >> testUpdateStrongFocusWhenAMainMetricIsClick [
| entities |
	entities := dashboardApp dashboard firstMetric.

	entities mainMetricValue performAction.
	self
		assert: dashboardApp strongFocus
		equals: dashboardApp context focusedEntities.
	self assert: dashboardApp strongFocus size equals: 6
]

{ #category : #tests }
TestDashboardApp >> testUpdateStrongFocusWhenSubMetricsIsClick [
	| entities |
	entities := dashboardApp dashboard firstMetric.

	"Core"
	(entities subMetric: 1) performAction.
	self assert: dashboardApp strongFocus size equals: 0.
	self
		assert: dashboardApp strongFocus
		equals: (dashboardApp context subQuery: 1) entities.

	"Big Classes"
	(entities subMetric: 2) performAction.
	self assert: dashboardApp strongFocus size equals: 1.
	self
		assert: dashboardApp strongFocus first
		equals: (dashboardApp context subQuery: 2) entities first.

	"Complex Classes"
	(entities subMetric: 3) performAction.
	self assert: dashboardApp strongFocus size equals: 1.
	self
		assert: dashboardApp strongFocus first
		equals: (dashboardApp context subQuery: 3) entities first
]

{ #category : #tests }
TestDashboardApp >> testWindowTitle [
	self
		assert: dashboardApp window title
		equals: 'MIDAS Dashboard: First-lanModel'.
	launcherApp context mooseModel: models second.
	self
		assert: dashboardApp window title
		equals: 'MIDAS Dashboard: Second-simpleModel'
]
