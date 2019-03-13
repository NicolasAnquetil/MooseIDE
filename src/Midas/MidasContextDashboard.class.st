"
Context for the dashboard app. Contains the metrics displayed by the dashboard
"
Class {
	#name : #MidasContextDashboard,
	#superclass : #MidasChildContext,
	#instVars : [
		'metrics',
		'subQueries'
	],
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextDashboard >> acceptStrongFocusUpdate: newFocus [
	^ newFocus isCollection
]

{ #category : #notifications }
MidasContextDashboard >> acceptWeakFocusUpdate: newFocus [
	^ false
]

{ #category : #accessing }
MidasContextDashboard >> focusedEntities [
	"for compatibility with MVSMainPresenter"
	| entities |
	entities := self strongFocus.
	^ (entities isKindOf: MooseModel)
		ifTrue: [ self mooseModel allModelClasses ]
		ifFalse: [ entities ]
]

{ #category : #accessing }
MidasContextDashboard >> focusedEntities: anObject [
	"for compatibility with MVSMainPresenter"
	self strongFocus: anObject
]

{ #category : #initialization }
MidasContextDashboard >> initialize [
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
MidasContextDashboard >> metric: id [
	^ metrics at: id
]

{ #category : #accessing }
MidasContextDashboard >> mooseModelSummary [
	^ {self mooseModel allModelNamespaces.
	self mooseModel allModelClasses.
	self mooseModel allModelMethods}
]

{ #category : #accessing }
MidasContextDashboard >> subQuery: id [
	^ subQueries at: id
]
