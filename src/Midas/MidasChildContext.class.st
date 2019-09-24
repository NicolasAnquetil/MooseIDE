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
	#category : #'Midas-appModel'
}

{ #category : #notifications }
MidasChildContext >> acceptMidasFocusUpdate: newFocus [
	^ true
]

{ #category : #notifications }
MidasChildContext >> acceptModelUpdate: newModel [
	^ true
]

{ #category : #actions }
MidasChildContext >> exit [
	parentContext removeChild: self.
	app delete.
	app := nil
]

{ #category : #notifications }
MidasChildContext >> formatMidasFocus: newFocus [
	^ newFocus
]

{ #category : #notifications }
MidasChildContext >> formatNewModel: newModel [
	^ newModel
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
MidasChildContext >> midasFocus [
	^ parentContext midasFocus
]

{ #category : #accessing }
MidasChildContext >> midasFocus: focus [
	parentContext midasFocus: focus
]

{ #category : #accessing }
MidasChildContext >> midasFocusIsModel [
	^ parentContext midasFocusIsModel
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
MidasChildContext >> notifyMidasFocus: newFocus [
	frozen
		ifTrue: [ ^ self ].
	(self acceptMidasFocusUpdate: newFocus)
		ifTrue: [ app updateMidasFocus: (self formatMidasFocus: newFocus) ]
]

{ #category : #notifications }
MidasChildContext >> notifyNewModel: newMooseModel [
	frozen
		ifTrue: [ ^ self ].
	(self acceptModelUpdate: newMooseModel)
		ifTrue: [ app updateModel: (self formatNewModel: newMooseModel) ]
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
MidasChildContext >> unfreeze [
	frozen := false.
]
