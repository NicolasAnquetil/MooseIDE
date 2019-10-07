"
I represent a Famix empty list of entity
"
Class {
	#name : #MidasEntityEmpty,
	#superclass : #MidasEntityAbstract,
	#category : #'Midas-focusModel'
}

{ #category : #'as yet unclassified' }
MidasEntityEmpty class >> ancestor: aMidasEntity [
	^ self new
			ancestor: aMidasEntity ;
			yourself
]

{ #category : #formatting }
MidasEntityEmpty >> ancestors [
	^ #()
]

{ #category : #accessing }
MidasEntityEmpty >> childrenFor: anAncestor [
	^#()
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

{ #category : #testing }
MidasEntityEmpty >> isEmpty [
	^ true
]

{ #category : #indexing }
MidasEntityEmpty >> pathsFor: midasEntities [
	^#()
]

{ #category : #indexing }
MidasEntityEmpty >> selectEntitiesIndexed: indexes [
	^self
]

{ #category : #indexing }
MidasEntityEmpty >> selectPathsIndexed: indexes [
	^self
]

{ #category : #accessing }
MidasEntityEmpty >> size [
	"optimization"
	^0
]
