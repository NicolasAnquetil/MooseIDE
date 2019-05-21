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
MidasContextDashboard >> acceptModelUpdate: newFocus [
	^ true
]

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

	^ (self strongFocusIsModel)
		ifNotNil: [ self mooseModel allModelClasses ]
		ifNil: [ self flattenedStrongFocus ]
]

{ #category : #accessing }
MidasContextDashboard >> focusedEntities: anObject [
	"for compatibility with MVSMainPresenter"
	self strongFocus: anObject
]

{ #category : #accessing }
MidasContextDashboard >> formatNewStrongFocus: newFocus [
	^self strongFocusIsModel
		ifTrue: [ self mooseModel allModelClasses ]
		ifFalse: [ newFocus ]
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

{ #category : #notifications }
MidasContextDashboard >> notifyNewModel: newMooseModel [
	app updateStrongFocus: newMooseModel allModelClasses
]

{ #category : #accessing }
MidasContextDashboard >> subQuery: id [
	^ subQueries at: id
]
