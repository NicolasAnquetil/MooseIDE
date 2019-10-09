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
		'parentContext',
		'hierarchicalFocus',
		'myFocusFrozen'
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

{ #category : #hierarchicalFocus }
MidasChildContext >> childrenFor: aRoot [
	^hierarchicalFocus
		ifTrue:  [ self midasFocus childrenFor: aRoot ]
		ifFalse: [ #() ]
		
]

{ #category : #actions }
MidasChildContext >> exit [
	parentContext removeChild: self.
	app delete.
	app := nil
]

{ #category : #hierarchicalFocus }
MidasChildContext >> focusBeFlat [
	hierarchicalFocus := false.
	self notifyMidasFocus: self midasFocus
]

{ #category : #hierarchicalFocus }
MidasChildContext >> focusBeHierarchical [
	hierarchicalFocus := true.
	self notifyMidasFocus: self midasFocus
]

{ #category : #hierarchicalFocus }
MidasChildContext >> focusIsHierarchical [
	^hierarchicalFocus
]

{ #category : #frozenFocus }
MidasChildContext >> focusOnSelection: selectedIndexes [
	"forces receiver to focus on the selection, whatever the states of the flags frozen and selectionFrozen"
	| wasFrozen |
	wasFrozen := frozen.
	frozen := false.
	self notifyMidasFocus: self midasFocus.
	frozen := wasFrozen.
]

{ #category : #notifications }
MidasChildContext >> formatMidasFocus: newFocus [
	^ newFocus
]

{ #category : #notifications }
MidasChildContext >> formatNewModel: newModel [
	^ newModel
]

{ #category : #frozenFocus }
MidasChildContext >> freeze [
	myFocusFrozen := self midasFocus.
	frozen := true.
]

{ #category : #initialization }
MidasChildContext >> initialize [
	super initialize.
	frozen := false.
	hierarchicalFocus := false
]

{ #category : #frozenFocus }
MidasChildContext >> isFrozen [
	^frozen
]

{ #category : #accessing }
MidasChildContext >> midasFocus [
	^self isFrozen
		ifTrue:  [ myFocusFrozen ]
		ifFalse: [ parentContext midasFocus ]
]

{ #category : #accessing }
MidasChildContext >> midasFocus: focus [
	parentContext midasFocus: focus
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
		ifTrue: [ self notifyMidasFocusFrozen: newFocus ]
		ifFalse: [ (self acceptMidasFocusUpdate: newFocus)
						ifTrue: [ app updateMidasFocus: (self formatMidasFocus: newFocus) ] ]
]

{ #category : #notifications }
MidasChildContext >> notifyMidasFocusFrozen: newFocus [
	"defaults to nothing"
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

{ #category : #hierarchicalFocus }
MidasChildContext >> roots [
	^self roots: self midasFocus
]

{ #category : #hierarchicalFocus }
MidasChildContext >> roots: aFocus [
	^hierarchicalFocus
		ifTrue:  [ aFocus ancestors ]
		ifFalse: [ aFocus entities ]

]

{ #category : #frozenFocus }
MidasChildContext >> unfreeze [
	frozen := false.
]
