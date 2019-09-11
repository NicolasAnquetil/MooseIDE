Class {
	#name : #MidasQueryMetricThreshold,
	#superclass : #MidasQuery,
	#instVars : [
		'threshold'
	],
	#category : #'Midas-helpers'
}

{ #category : #accessing }
MidasQueryMetricThreshold >> firstEntitiesFor: aSelector [
	| allEntities nbEntitesToSelect |
	allEntities := masterModel focusedEntities.
	nbEntitesToSelect := (allEntities size * threshold) asInteger.
	^ (allEntities
		sort: [ :a :b | (a perform: aSelector) > (b perform: aSelector) ])
		copyFrom: 1
		to: nbEntitesToSelect
]

{ #category : #accessing }
MidasQueryMetricThreshold >> threshold [
	^ threshold
]

{ #category : #accessing }
MidasQueryMetricThreshold >> threshold: anObject [
	threshold := anObject
]
