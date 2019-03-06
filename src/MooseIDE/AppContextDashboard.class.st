"
Context for the dashboard app. Contains the metrics displayed by the dashboard
"
Class {
	#name : #AppContextDashboard,
	#superclass : #AppContext,
	#instVars : [
		'metrics',
		'subQueries'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #accessing }
AppContextDashboard >> focusedEntities [
	| entities |
	entities := self focus.
	^( entities isKindOf: MooseModel)
		ifTrue: [  self mooseModel allModelClasses  ]
		ifFalse: [ entities ]
]

{ #category : #accessing }
AppContextDashboard >> focusedEntities: anObject [
	self focus: anObject
]

{ #category : #initialization }
AppContextDashboard >> initialize [
	super initialize.
	metrics := {MDMetricNumberOfEntities new.
	MDMetricLOC new.
	MDMetricCyclomaticComplexity new} asOrderedCollection.
	subQueries := {(MDQueryCore new master: self).
	(MDQueryBig new
		master: self;
		threshold: 20 percent).
	(MDQueryComplex new
		master: self;
		threshold: 20 percent)} asOrderedCollection
]

{ #category : #accessing }
AppContextDashboard >> metric: id [
	^ metrics at: id
]

{ #category : #accessing }
AppContextDashboard >> mooseModelSummary [
	^ { self mooseModel allModelPackages.
	self mooseModel allModelNamespaces.
	self mooseModel allModelClasses.
	self mooseModel allModelMethods.
	self mooseModel allModelNamespaces first}
]

{ #category : #accessing }
AppContextDashboard >> subQuery: id [
	^ subQueries at: id
]
