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

{ #category : #accessing }
MidasContextDashboard >> focusedEntities [
	self focusIsMooseModel
		ifTrue: [ ^ self mooseModel allModelClasses ].
	self midasFocus isCollection
		ifTrue: [ ^ self midasFocus ].
	^ {self midasFocus}
]

{ #category : #accessing }
MidasContextDashboard >> formatMidasFocus: newFocus [
	^ self midasFocusIsModel
		ifTrue: [ self mooseModel allModelClasses ]
		ifFalse: [ newFocus ]
]

{ #category : #initialization }
MidasContextDashboard >> initialize [
	super initialize.
	metrics := {MidasMetricNumberOfEntities new.
	MidasMetricLOC new.
	MidasMetricCyclomaticComplexity new} asOrderedCollection.
	subQueries := {(MidasQueryCore new master: self).
	(MidasQueryBig new
		master: self;
		threshold: 20 percent).
	(MidasQueryComplex new
		master: self;
		threshold: 20 percent)} asOrderedCollection
]

{ #category : #accessing }
MidasContextDashboard >> metric: id [
	^ metrics at: id
]

{ #category : #accessing }
MidasContextDashboard >> subQuery: id [
	^ subQueries at: id
]
