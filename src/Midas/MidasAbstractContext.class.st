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
	#category : #'Midas-appModel'
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
	self notifyMidasFocus: self midasFocus
]

{ #category : #accessing }
MidasAbstractContext >> midasFocus [
	self subclassResponsibility
]

{ #category : #accessing }
MidasAbstractContext >> midasFocus: newFocus [
	self subclassResponsibility
]

{ #category : #accessing }
MidasAbstractContext >> modelName [
	^self mooseModel ifNil: [ '--' ] ifNotNil: [ :model | model displayString ]
]

{ #category : #accessing }
MidasAbstractContext >> mooseModel [
	self subclassResponsibility 
]

{ #category : #accessing }
MidasAbstractContext >> mooseModel: aMooseModel [
	self subclassResponsibility 
]

{ #category : #notifications }
MidasAbstractContext >> notifyMidasFocus: newFocus [
	self subclassResponsibility 
]

{ #category : #notifications }
MidasAbstractContext >> notifyNewModel: newMooseModel [
	self subclassResponsibility 
]
