Class {
	#name : #MidasEntityEmpty,
	#superclass : #MidasEntityAbstract,
	#category : #'Midas-context'
}

{ #category : #'as yet unclassified' }
MidasEntityEmpty class >> ancestor: aMidasEntity [
	^ self new
			ancestor: aMidasEntity ;
			yourself
]

{ #category : #formatting }
MidasEntityEmpty >> displayString [
	^ '--'
]

{ #category : #formatting }
MidasEntityEmpty >> entities [
	^ #()
]

{ #category : #running }
MidasEntityEmpty >> indexInListWithoutAncestors: index [
	^ 0
]

{ #category : #testing }
MidasEntityEmpty >> isEmpty [
	^ true
]

{ #category : #'as yet unclassified' }
MidasEntityEmpty >> nextGenerationSelector: aSelector [
	^self
]

{ #category : #running }
MidasEntityEmpty >> selectEntitiesIndexed: indexes [
	^ self
]
