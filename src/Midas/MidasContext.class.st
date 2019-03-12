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
		'focusStrong',
		'focusWeak',
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
	^ self strongFocus
]

{ #category : #accessing }
MidasContext >> focus: anObject [
	self strongFocus: anObject
]

{ #category : #accessing }
MidasContext >> freeze [
	focusStrong := self strongFocus.
	focusWeak := self weakFocus.
	frozen := true
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
MidasContext >> notifyAllStrong [
	parentContext notifyAllStrong
]

{ #category : #notifications }
MidasContext >> notifyAllWeak [
	parentContext notifyAllWeak
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
MidasContext >> strongFocus [
	^ frozen
		ifTrue: [ focusStrong ]
		ifFalse: [ parentContext strongFocus ]
]

{ #category : #accessing }
MidasContext >> strongFocus: anObject [
	frozen
		ifTrue: [ focusStrong := anObject ]
		ifFalse: [ parentContext strongFocus: anObject ]
]

{ #category : #accessing }
MidasContext >> unfreeze [
	frozen := false.
]

{ #category : #accessing }
MidasContext >> weakFocus [
	^ parentContext weakFocus
]

{ #category : #accessing }
MidasContext >> weakFocus: anObject [
	parentContext weakFocus: anObject 
]
