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

{ #category : #'as yet unclassified' }
AppContextDashboard >> focusedEntitiesCore [
	^ (self mooseModel allModelClasses)
		ifEmpty: [ #() ]
		ifNotEmpty: [ :cls | 
			(cls select: [ :each | each container mooseName asLowercase matchesRegex: '.*core.*' ])
				asSet ]
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

{ #category : #'as yet unclassified' }
AppContextDashboard >> percentOfBigClasses [
	| classes |
	classes := self mooseModel allModelClasses.
	^ (classes asOrderedCollection
		sort: [ :a :b | a numberOfLinesOfCode > b numberOfLinesOfCode ])
		copyFrom: 1
		to: (classes size * 0.2) asInteger
]

{ #category : #'as yet unclassified' }
AppContextDashboard >> percentOfComplexeClasses [
	| classes |
	classes := self mooseModel allModelClasses.
	^ (classes asOrderedCollection
		sort: [ :a :b | a cyclomaticComplexity > b cyclomaticComplexity ])
		copyFrom: 1
		to: (classes size * 0.2) asInteger
]

{ #category : #accessing }
AppContextDashboard >> percentage [
	^ 0.2
]

{ #category : #accessing }
AppContextDashboard >> percentage: aNumber [
]
