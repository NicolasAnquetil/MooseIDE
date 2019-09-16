"
I am a MidasEntity with exactly one inner Famix entity.

"
Class {
	#name : #MidasEntityFamix,
	#superclass : #MidasEntitySingle,
	#category : #'Midas-context'
}

{ #category : #'instance creation' }
MidasEntityFamix class >> with: anEntity [
	^self new
		famix: anEntity ;
		yourself
]

{ #category : #accessing }
MidasEntityFamix >> displayString [
	^ singleEntity name
]

{ #category : #accessing }
MidasEntityFamix >> famix: aFamixEntity [
	singleEntity := aFamixEntity
]
