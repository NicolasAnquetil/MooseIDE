Class {
	#name : #MidasQueryComplex,
	#superclass : #MidasQueryMetricThreshold,
	#category : #'Midas-dashboardhelpers'
}

{ #category : #accessing }
MidasQueryComplex >> displayName [
	^ 'Complex Classes'
]

{ #category : #accessing }
MidasQueryComplex >> entities [
	^self firstEntitiesFor: #cyclomaticComplexity
]
