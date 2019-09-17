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
	self midasFocus isModel
		ifTrue: [ ^ self mooseModel allModelClasses ].
	^self midasFocus entities
]

{ #category : #initialization }
MidasContextDashboard >> initialize [
	super initialize.
	metrics := {
		MidasMetricNumberOfEntities new .
		MidasMetricLOC new .
		MidasMetricCyclomaticComplexity new } asOrderedCollection.
	subQueries := {
		(MidasQueryCore new master: self) .
		(MidasQueryBig new
			master: self;
			threshold: 20 percent) .
		(MidasQueryComplex new
			master: self;
			threshold: 20 percent) } asOrderedCollection
]

{ #category : #accessing }
MidasContextDashboard >> metric: id [
	^ metrics at: id
]

{ #category : #accessing }
MidasContextDashboard >> subQuery: id [
	^ subQueries at: id
]
