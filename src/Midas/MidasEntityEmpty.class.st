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

{ #category : #accessing }
MidasEntityEmpty >> entitiesWithAncestors [
	^ { ancestor -> #() }
]

{ #category : #running }
MidasEntityEmpty >> indexInListWithoutAncestors: index [
	^ 0
]

{ #category : #testing }
MidasEntityEmpty >> isEmpty [
	^ true
]

{ #category : #'instance creation' }
MidasEntityEmpty >> selectEntitiesIndexed: indexes [
	^self
]

{ #category : #accessing }
MidasEntityEmpty >> size [
	"optimization"
	^0
]
