"
I represent the LCOM3 cohesion Metric 
"
Class {
	#name : #MidasMetricLCOM3,
	#superclass : #MidasAbstractMetric,
	#category : #'Midas-dashboardhelpers'
}

{ #category : #accessing }
MidasMetricLCOM3 class >> displayName [
	^ 'LCOM3'
]

{ #category : #compute }
MidasMetricLCOM3 >> aggregateMetricFor: aCollection [
	^self averageMetricFor: aCollection 
]

{ #category : #compute }
MidasMetricLCOM3 >> computeMetricFor: anEntity [
	^ [anEntity lcom3]
		on: MessageNotUnderstood
		do: [ 0 ]
]
