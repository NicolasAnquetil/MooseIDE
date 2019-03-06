"
The execution context of an App.
Knows what i the MooseModel one is working on and the currently selected (focused) entity-ies.
Context are organized in a hierarchy. The root is the context of the launcher, it has the actual mooseModel we are working on and the actual current focus.
All context know their parent context
"
Class {
	#name : #MidasContext,
	#superclass : #Object,
	#instVars : [
		'focus',
		'frozen',
		'parentContext',
		'listeners'
	],
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContext >> addListener: aListener [
	parentContext addListener: aListener
]

{ #category : #accessing }
MidasContext >> focus [
	^frozen
		ifTrue: [ focus ]
		ifFalse: [  parentContext  focus ]
]

{ #category : #accessing }
MidasContext >> focus: anObject [
	frozen
		ifTrue: [ focus := anObject ]
		ifFalse: [  parentContext  focus: anObject ].
]

{ #category : #accessing }
MidasContext >> freeze [
	focus := self focus.
	frozen := true.
]

{ #category : #initialization }
MidasContext >> initialize [
	frozen := false.
]

{ #category : #accessing }
MidasContext >> mooseModel [
	^ parentContext mooseModel
]

{ #category : #accessing }
MidasContext >> mooseModel: aMooseModel [
	parentContext mooseModel: aMooseModel
]

{ #category : #notifications }
MidasContext >> notifyAll [
	parentContext notifyAll
]

{ #category : #accessing }
MidasContext >> parentContext [
	^ parentContext
]

{ #category : #accessing }
MidasContext >> parentContext: anAppContext [
	parentContext := anAppContext
]

{ #category : #'instance creation' }
MidasContext >> spawn: aContextClass [
	| child |
	child := aContextClass new.
	child parentContext: self.
	^ child
]

{ #category : #accessing }
MidasContext >> unfreeze [
	frozen := false.
]
