"
I represent a Famix entity seen has a list of entities in Midas
"
Class {
	#name : #MidasEntityFamix,
	#superclass : #MidasEntitySingle,
	#category : #'Midas-focusModel'
}

{ #category : #formatting }
MidasEntityFamix >> ancestors [
	^ { ancestor }
]

{ #category : #accessing }
MidasEntityFamix >> childrenFor: anAncestor [
	^(anAncestor = ancestor)
		ifTrue: [ self entities ]
		ifFalse: [ #() ]
]

{ #category : #formatting }
MidasEntityFamix >> displayString [
	^ singleEntity name
]

{ #category : #testing }
MidasEntityFamix >> hasSourceAnchor [
	^ singleEntity hasSourceAnchor
]
