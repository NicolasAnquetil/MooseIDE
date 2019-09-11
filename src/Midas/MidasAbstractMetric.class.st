"
I representant abstract metric on a moose entity.
I can compute my value on the entity or aggregate my values over a collection of entities
"
Class {
	#name : #MidasAbstractMetric,
	#superclass : #Object,
	#category : #'Midas-gui'
}

{ #category : #accessing }
MidasAbstractMetric class >> displayName [
	^'Unknown metric'
]

{ #category : #compute }
MidasAbstractMetric >> aggregateMetricFor: aCollection [
	self subclassResponsibility
]

{ #category : #compute }
MidasAbstractMetric >> averageMetricFor: aCollection [
	| col |
	col := aCollection collect: [ :each | self computeMetricFor: each ].
	col ifEmpty: [ ^ 0 ].
	^ col average
]

{ #category : #compute }
MidasAbstractMetric >> computeMetricFor: anEntity [
	self subclassResponsibility
]

{ #category : #accessing }
MidasAbstractMetric >> displayName [
	^self class displayName
]

{ #category : #compute }
MidasAbstractMetric >> minMetricFor: aCollection [
	^ (aCollection collect: [ :each | self computeMetricFor: each ]) min
]

{ #category : #compute }
MidasAbstractMetric >> sumMetricFor: aCollection [
	| col |
	col := (aCollection collect: [ :each | self computeMetricFor: each ])
		asOrderedCollection.
	col ifEmpty: [ ^ 0 ].
	^ col sum
]
