"
I represent the LinesOfCode Metric 
"
Class {
	#name : #MidasMetricLOC,
	#superclass : #MidasAbstractMetric,
	#category : #'Midas-gui'
}

{ #category : #accessing }
MidasMetricLOC class >> displayName [
	^ 'LOC'
]

{ #category : #compute }
MidasMetricLOC >> aggregateMetricFor: aCollection [
	^ self sumMetricFor: aCollection
]

{ #category : #compute }
MidasMetricLOC >> computeMetricFor: anEntity [
	^ anEntity numberOfLinesOfCode
]
