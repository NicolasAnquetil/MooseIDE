"
Generic context for the children of MidasContextLauncher.

It has a parentContext (typically MidasContextLauncher) and can be frozen.
Frozen context do not answer to strong/weak selections
"
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
MidasChildContext >> acceptModelUpdate: newModel [
	^ false
]

{ #category : #notifications }
MidasChildContext >> acceptStrongFocusUpdate: newFocus [
	^ true
]

{ #category : #notifications }
MidasChildContext >> acceptWeakFocusUpdate: newFocus [
	^ true
]

{ #category : #actions }
MidasChildContext >> exit [
	parentContext := nil.
	app delete.
	app := nil
]

{ #category : #accessing }
MidasChildContext >> flattenedStrongFocus [
	^parentContext flattenedStrongFocus
]

{ #category : #notifications }
MidasChildContext >> formatNewFocus: newFocus [
	^newFocus 
]

{ #category : #notifications }
MidasChildContext >> formatNewModel: newMooseModel [
	^newMooseModel
]

{ #category : #accessing }
MidasChildContext >> freeze [
	frozen := true
]

{ #category : #accessing }
MidasChildContext >> frozen [
	^frozen
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

{ #category : #accessing }
MidasChildContext >> mooseModelAsGroups [
	^parentContext mooseModelAsGroups

]

{ #category : #notifications }
MidasChildContext >> notifyNewModel: newMooseModel [
	(self acceptModelUpdate: newMooseModel)
		ifTrue: [ app updateModel: (self formatNewModel: newMooseModel) ]
		ifFalse: [	self notifyStrongFocus: self strongFocus]
]

{ #category : #notifications }
MidasChildContext >> notifyStrongFocus: newFocus [
	frozen ifTrue: [ ^self ].
	(self acceptStrongFocusUpdate: newFocus )
		ifTrue: [ app updateStrongFocus: (self formatNewFocus: newFocus) ]
]

{ #category : #notifications }
MidasChildContext >> notifyWeakFocus: newFocus [
	frozen ifTrue: [ ^self ].
	(self acceptWeakFocusUpdate: newFocus)
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
	^ parentContext strongFocus
]

{ #category : #accessing }
MidasChildContext >> strongFocus: anObject [
	parentContext strongFocus: anObject
]

{ #category : #accessing }
MidasChildContext >> strongFocusIsModel [
	^ parentContext strongFocusIsModel
]

{ #category : #accessing }
MidasChildContext >> unfreeze [
	frozen := false.
]

{ #category : #accessing }
MidasChildContext >> weakFocus [
	^parentContext weakFocus
]

{ #category : #accessing }
MidasChildContext >> weakFocus: anObject [
	parentContext weakFocus: anObject 
]
