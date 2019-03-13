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
		'focusStrong',
		'focusWeak',
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

{ #category : #notifications }
MidasAbstractContext >> notifyNewModel: newMooseModel [
	self subclassResponsibility 
]

{ #category : #notifications }
MidasAbstractContext >> notifyStrongFocus: newFocus [
	self subclassResponsibility 
]

{ #category : #notifications }
MidasAbstractContext >> notifyWeakFocus: newFocus [
	self subclassResponsibility
]

{ #category : #accessing }
MidasAbstractContext >> strongFocus [
	"implementation depends on subclasses even if instance variable is defined in this class"

	self subclassResponsibility
]

{ #category : #accessing }
MidasAbstractContext >> strongFocus: newFocus [
	"implementation depends on subclasses even if instance variable is defined in this class"
	self subclassResponsibility 
]

{ #category : #accessing }
MidasAbstractContext >> weakFocus [
	"implementation depends on subclasses even if instance variable is defined in this class"

	self subclassResponsibility
]

{ #category : #accessing }
MidasAbstractContext >> weakFocus: newFocus [
	"implementation depends on subclasses even if instance variable is defined in this class"

	self subclassResponsibility
]
