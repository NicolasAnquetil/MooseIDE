"
I am a MidasEntity with exactly one inner MooseModel.

"
Class {
	#name : #MidasEntityMooseModel,
	#superclass : #MidasEntitySingle,
	#category : #'Midas-focusModel'
}

{ #category : #'instance creation' }
MidasEntityMooseModel class >> with: aMooseModel [
	^self with: aMooseModel ancestor: nil
]

{ #category : #accessing }
MidasEntityMooseModel >> ancestors [
	^ { singleEntity }
]

{ #category : #accessing }
MidasEntityMooseModel >> childrenFor: anAncestor [
	^ #()
]

{ #category : #formatting }
MidasEntityMooseModel >> displayString [
	^ 'Model: ' , singleEntity name
]

{ #category : #testing }
MidasEntityMooseModel >> isModel [
	^ true
]

{ #category : #meta }
MidasEntityMooseModel >> metamodel [
	^ singleEntity metamodel
]

{ #category : #testing }
MidasEntityMooseModel >> sameModel: aMooseModel [
	^ singleEntity = aMooseModel
]
