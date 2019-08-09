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
	^ true
]

{ #category : #notifications }
MidasChildContext >> acceptStrongFocusUpdate: newFocus [
	^ true
]

{ #category : #actions }
MidasChildContext >> exit [
	parentContext removeChild: self.
	app delete.
	app := nil
]

{ #category : #notifications }
MidasChildContext >> formatNewModel: newMooseModel [
	^ newMooseModel
]

{ #category : #notifications }
MidasChildContext >> formatNewStrongFocus: newFocus [
	^newFocus 
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

{ #category : #notifications }
MidasChildContext >> notifyNewModel: newMooseModel [
	frozen
		ifTrue: [ ^ self ].
	(self acceptModelUpdate: newMooseModel)
		ifTrue: [ app updateModel: (self formatNewModel: newMooseModel) ]
]

{ #category : #notifications }
MidasChildContext >> notifyStrongFocus: newFocus [
	frozen
		ifTrue: [ ^ self ].
	(self acceptStrongFocusUpdate: newFocus)
		ifTrue: [ app updateStrongFocus: (self formatNewStrongFocus: newFocus) ]
]

{ #category : #accessing }
MidasChildContext >> parentContext [
	^ parentContext
]

{ #category : #accessing }
MidasChildContext >> parentContext: aContext [
	parentContext = aContext
		ifTrue: [ ^ self ].
	parentContext := aContext.
	aContext addChild: self
]

{ #category : #accessing }
MidasChildContext >> strongFocus [
	^ parentContext strongFocus
]

{ #category : #accessing }
MidasChildContext >> strongFocus: focus [
	parentContext strongFocus: focus
]

{ #category : #accessing }
MidasChildContext >> strongFocusIsModel [
	^ parentContext strongFocusIsModel
]

{ #category : #accessing }
MidasChildContext >> unfreeze [
	frozen := false.
]
