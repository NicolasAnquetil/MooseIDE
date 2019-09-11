Class {
	#name : #MidasMetricNumberOfEntities,
	#superclass : #MidasAbstractMetric,
	#category : #'Midas-gui'
}

{ #category : #accessing }
MidasMetricNumberOfEntities class >> displayName [
	^ '# Entities'
]

{ #category : #compute }
MidasMetricNumberOfEntities >> aggregateMetricFor: aCollection [
	^ self sumMetricFor: aCollection
]

{ #category : #compute }
MidasMetricNumberOfEntities >> computeMetricFor: anEntity [
	^ 1
]
