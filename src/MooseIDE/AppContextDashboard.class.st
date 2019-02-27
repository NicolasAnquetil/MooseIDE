Class {
	#name : #AppContextDashboard,
	#superclass : #AppContext,
	#instVars : [
		'metrics'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #accessing }
AppContextDashboard >> addMetric: aMetric [
	metrics add: aMetric
]

{ #category : #accessing }
AppContextDashboard >> focusedEntities [
	^self focus
		ifNil: [ self mooseModel allModelClasses ]
]

{ #category : #initialization }
AppContextDashboard >> initialize [
	super initialize.
	metrics := OrderedCollection new.
	self addMetric: MDMetricLOC new.
	self addMetric: MDMetricLCOM3 new.
	self addMetric: MDMetricCyclomaticComplexity new.

]

{ #category : #accessing }
AppContextDashboard >> metrics [
	^metrics
]
