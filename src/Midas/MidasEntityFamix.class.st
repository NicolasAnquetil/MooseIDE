Class {
	#name : #MidasEntityFamix,
	#superclass : #MidasEntitySingle,
	#category : #'Midas-context'
}

{ #category : #formatting }
MidasEntityFamix >> displayString [
	^ singleEntity name
]

{ #category : #testing }
MidasEntityFamix >> hasSourceAnchor [
	^ singleEntity hasSourceAnchor
]
