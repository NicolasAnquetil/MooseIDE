Class {
	#name : #MidasChildContext,
	#superclass : #MidasAbstractContext,
	#instVars : [
		'frozen',
		'parentContext'
	],
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasChildContext >> acceptStrongFocus: newFocus [
	^ true
]

{ #category : #notifications }
MidasChildContext >> acceptWeakFocus: newFocus [
	^ true
]

{ #category : #accessing }
MidasChildContext >> freeze [
	focusStrong := self strongFocus.
	focusWeak := self weakFocus.
	frozen := true
]

{ #category : #initialization }
MidasChildContext >> initialize [
	frozen := false.
]

{ #category : #accessing }
MidasChildContext >> mooseModel [
	^ parentContext mooseModel
]

{ #category : #accessing }
MidasChildContext >> mooseModel: aMooseModel [
	parentContext mooseModel: aMooseModel
]

{ #category : #notifications }
MidasChildContext >> notifyModel: newMooseModel [
	self notifyStrongFocus: self strongFocus

	
]

{ #category : #notifications }
MidasChildContext >> notifyStrongFocus: newFocus [
	(self acceptStrongFocus: newFocus)
		ifTrue: [ app updateStrongFocus: newFocus ]
]

{ #category : #notifications }
MidasChildContext >> notifyWeakFocus: newFocus [
	(self acceptWeakFocus: newFocus)
		ifTrue: [ app updateWeakFocus: newFocus ]
]

{ #category : #accessing }
MidasChildContext >> parentContext [
	^ parentContext
]

{ #category : #accessing }
MidasChildContext >> parentContext: aContext [
	parentContext = aContext 
		ifTrue: [ ^ self].
	parentContext := aContext.
	aContext addChild: self
]

{ #category : #accessing }
MidasChildContext >> strongFocus [
	^ frozen
		ifTrue: [ focusStrong ]
		ifFalse: [ parentContext strongFocus ]
]

{ #category : #accessing }
MidasChildContext >> strongFocus: anObject [
	frozen
		ifTrue: [  ]
		ifFalse: [ parentContext strongFocus: anObject ]
]

{ #category : #accessing }
MidasChildContext >> unfreeze [
	frozen := false.
]

{ #category : #accessing }
MidasChildContext >> weakFocus [
	^ parentContext weakFocus
]

{ #category : #accessing }
MidasChildContext >> weakFocus: anObject [
	parentContext weakFocus: anObject 
]
