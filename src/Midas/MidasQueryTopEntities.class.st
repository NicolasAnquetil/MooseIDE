"
Abstract subclass of a MidasQuery that selects the top entities for a given threshold.
assumes all entities can be sorted in decreasing order of some selector value

threshold is a percentage of the entities to return
Defaults to 10%

"
Class {
	#name : #MidasQueryTopEntities,
	#superclass : #MidasQuery,
	#instVars : [
		'threshold'
	],
	#category : #'Midas-helpers'
}

{ #category : #initialization }
MidasQueryTopEntities >> initialize [
	super initialize.
	threshold := 0.1
]

{ #category : #accessing }
MidasQueryTopEntities >> threshold [
	^ threshold
]

{ #category : #accessing }
MidasQueryTopEntities >> threshold: aFloat [
	"threshold is a percentage [0..1]"
	threshold := aFloat
]

{ #category : #accessing }
MidasQueryTopEntities >> topEntitiesFor: aSelector [
	| allEntities nbToReturn |
	allEntities := context focusedEntities.
	nbToReturn := (allEntities size * threshold) asInteger.
	^ (allEntities
		sort: [ :a :b | (a perform: aSelector) > (b perform: aSelector) ])
		copyFrom: 1
		to: nbToReturn
]
