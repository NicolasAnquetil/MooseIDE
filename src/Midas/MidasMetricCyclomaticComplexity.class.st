"
I represent the cyclomatic complexity Metric 
"
Class {
	#name : #MidasMetricCyclomaticComplexity,
	#superclass : #MidasAbstractMetric,
	#category : #'Midas-gui'
}

{ #category : #accessing }
MidasMetricCyclomaticComplexity class >> displayName [
	^'Cyclomatic Complexity' 
]

{ #category : #compute }
MidasMetricCyclomaticComplexity >> aggregateMetricFor: aCollection [

	^ self averageMetricFor: aCollection
]

{ #category : #compute }
MidasMetricCyclomaticComplexity >> computeMetricFor: anEntity [
	^ [anEntity cyclomaticComplexity] 
		on: MessageNotUnderstood
		do: [ 1 ]
]
