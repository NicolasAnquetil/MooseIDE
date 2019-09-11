"
Concrete subclass of a MidasQueryTopEntities that selects the top big classes (in numberOfLinesOfCode)
"
Class {
	#name : #MidasQueryBig,
	#superclass : #MidasQueryTopEntities,
	#category : #'Midas-helpers'
}

{ #category : #accessing }
MidasQueryBig class >> displayName [
	^ 'Big Classes'
]

{ #category : #accessing }
MidasQueryBig >> entities [
	^ self topEntitiesFor: #numberOfLinesOfCode
]
