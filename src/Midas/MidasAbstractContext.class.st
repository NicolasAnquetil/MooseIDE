"
The execution context of an App.
Knows what i the MooseModel one is working on and the currently selected (focused) entity-ies.
Context are organized in a hierarchy. The root is the context of the launcher, it has the actual mooseModel we are working on and the actual current focus.
All context know their parent context
"
Class {
	#name : #MidasAbstractContext,
	#superclass : #Object,
	#instVars : [
		'app'
	],
	#category : #'Midas-context'
}

{ #category : #accessing }
MidasAbstractContext >> app [
	^ app
]

{ #category : #accessing }
MidasAbstractContext >> app: anApp [
	app = anApp
		ifTrue: [ ^ self ].
	app := anApp.
	anApp context: self.
	self notifyStrongFocus: self strongFocus
]

{ #category : #testing }
MidasAbstractContext >> focusIsMooseModel [
	^ self focusIsMooseModel: self strongFocus
]

{ #category : #testing }
MidasAbstractContext >> focusIsMooseModel: focus [
	^ focus = self mooseModel
]

{ #category : #accessing }
MidasAbstractContext >> modelName [
	^self mooseModel ifNil: [ '--' ] ifNotNil: [ :model | model name ]
]

{ #category : #accessing }
MidasAbstractContext >> mooseModel [
	self subclassResponsibility 
]

{ #category : #notifications }
MidasAbstractContext >> notifyNewModel: newMooseModel [
	self subclassResponsibility 
]

{ #category : #notifications }
MidasAbstractContext >> notifyStrongFocus: newFocus [
	self subclassResponsibility 
]

{ #category : #accessing }
MidasAbstractContext >> strongFocus [
	self subclassResponsibility
]

{ #category : #accessing }
MidasAbstractContext >> strongFocus: newFocus [
	self subclassResponsibility
]
