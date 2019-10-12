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

{ #category : #freezeUnfreeze }
MidasChildContext >> bypassFreeze [
	| wasFrozen |
	wasFrozen := self isFrozen.
	self unfreeze.
	wasFrozen ifTrue: [ self freeze ]
]

{ #category : #flatHierarchical }
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

{ #category : #flatHierarchical }
MidasChildContext >> focusBeFlat [
	"unfortunately there are interaction between freeze and hierarchical.
	 When we switch between flat and hierarchical, we want to update the display even if frozen"
	| wasFrozen myFocus |
	myFocus := self midasFocus.
	wasFrozen := self isFrozen.
	hierarchicalFocus := false.
	frozen := false. "not using #unfreeze to control call to #notifyMidasFocus:"
	self notifyMidasFocus: myFocus.
	frozen := wasFrozen.
	self notifyMidasFocus: parentContext midasFocus "possibly re-establishing selected entities"
]

{ #category : #flatHierarchical }
MidasChildContext >> focusBeHierarchical [
	hierarchicalFocus := true.
	self notifyMidasFocus: self midasFocus
]

{ #category : #flatHierarchical }
MidasChildContext >> focusIsHierarchical [
	^hierarchicalFocus
]

{ #category : #notifications }
MidasChildContext >> formatMidasFocus: newFocus [
	^ newFocus
]

{ #category : #notifications }
MidasChildContext >> formatNewModel: newModel [
	^ newModel
]

{ #category : #freezeUnfreeze }
MidasChildContext >> freeze [
	myFocusFrozen := self midasFocus.
	frozen := true.
	app enableBtnBypassFreeze
]

{ #category : #initialization }
MidasChildContext >> initialize [
	super initialize.
	frozen := false.
	hierarchicalFocus := false
]

{ #category : #freezeUnfreeze }
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
						ifTrue: [ app displayFocus: (self formatMidasFocus: newFocus) ] ]
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
		ifTrue: [ app displayModel: (self formatNewModel: newMooseModel) ]
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

{ #category : #flatHierarchical }
MidasChildContext >> roots [
	^self roots: self midasFocus
]

{ #category : #flatHierarchical }
MidasChildContext >> roots: aFocus [
	^hierarchicalFocus
		ifTrue:  [ aFocus ancestors ]
		ifFalse: [ aFocus entities ]

]

{ #category : #freezeUnfreeze }
MidasChildContext >> unfreeze [
	frozen := false.
	app disableBtnBypassFreeze.
	self notifyMidasFocus: self midasFocus.
]
