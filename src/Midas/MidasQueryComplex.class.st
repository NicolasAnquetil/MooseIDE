"
Concrete subclass of a MidasQueryTopEntities that selects the top complex classes (in cyclomaticComplexity)
"
Class {
	#name : #MidasQueryComplex,
	#superclass : #MidasQueryTopEntities,
	#category : #'Midas-helpers'
}

{ #category : #accessing }
MidasQueryComplex class >> displayName [
	^ 'Complex Classes'
]

{ #category : #accessing }
MidasQueryComplex >> entities [
	^self topEntitiesFor: #cyclomaticComplexity
]
