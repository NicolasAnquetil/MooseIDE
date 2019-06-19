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
TestDashboardApp >> testDisplayTheCorrectInformationOfTheCyclomaticComplexity [
		| myMetric value sub subValue |
	myMetric := dashboardApp context metric: 3.
	value := myMetric
		aggregateMetricFor: dashboardApp context focusedEntities.
	self
		assert: dashboardApp dashboard thirdMetric mainMetricValue label
		equals: (value truncateTo: 0.001) asString.
	1 to: 3 do: [ :i | 
		sub := dashboardApp context subQuery: i.
		subValue := myMetric aggregateMetricFor: sub entities.
		self
			assert: (dashboardApp dashboard thirdMetric subMetric: i) label
			equals: sub displayName , String cr , (subValue truncateTo: 0.001) asString ]
]

{ #category : #tests }
TestDashboardApp >> testDisplayTheCorrectInformationOfTheEntities [
	| myMetric value sub subValue |
	myMetric := dashboardApp context metric: 1.
	value := myMetric
		aggregateMetricFor: dashboardApp context focusedEntities.
	self
		assert: dashboardApp dashboard firstMetric mainMetricValue label
		equals: (value truncateTo: 0.001) asString.
	1 to: 3 do: [ :i | 
		sub := dashboardApp context subQuery: i.
		subValue := myMetric aggregateMetricFor: sub entities.
		self
			assert: (dashboardApp dashboard firstMetric subMetric: i) label
			equals: sub displayName , String cr ,(subValue truncateTo: 0.001) asString ]
]

{ #category : #tests }
TestDashboardApp >> testDisplayTheCorrectInformationOfTheLinesOfCode [
	| myMetric value sub subValue |
	myMetric := dashboardApp context metric: 2.
	value := myMetric
		aggregateMetricFor: dashboardApp context focusedEntities.
	self
		assert: dashboardApp dashboard secondMetric mainMetricValue label
		equals: (value truncateTo: 0.001) asString.
	1 to: 3 do: [ :i | 
		sub := dashboardApp context subQuery: i.
		subValue := myMetric aggregateMetricFor: sub entities.
		self
			assert: (dashboardApp dashboard secondMetric subMetric: i) label
			equals: sub displayName , String cr , (subValue truncateTo: 0.001) asString ]
]
