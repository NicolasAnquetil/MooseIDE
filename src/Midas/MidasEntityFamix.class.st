Class {
	#name : #MidasEntityFamix,
	#superclass : #MidasEntitySingle,
	#category : #'Midas-focusModel'
}

{ #category : #formatting }
MidasEntityFamix >> displayString [
	^ singleEntity name
]

{ #category : #testing }
MidasEntityFamix >> hasSourceAnchor [
	^ singleEntity hasSourceAnchor
]
