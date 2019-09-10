Class {
	#name : #MidasQueryBig,
	#superclass : #MidasQueryMetricThreshold,
	#category : #'Midas-dashboardhelpers'
}

{ #category : #accessing }
MidasQueryBig >> displayName [
	^ 'Big Classes'
]

{ #category : #accessing }
MidasQueryBig >> entities [
	^ self firstEntitiesFor: #numberOfLinesOfCode
]
