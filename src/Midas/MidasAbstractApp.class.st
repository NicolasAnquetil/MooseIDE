"
Abstract app. Apps are specialized Spec visualization. All app have a context which is the model of the visualization
"
Class {
	#name : #MidasAbstractApp,
	#superclass : #ComposablePresenter,
	#instVars : [
		'context',
		'freeze'
	],
	#category : #'Midas-apps'
}

{ #category : #accessing }
MidasAbstractApp >> context [
	^ context
]

{ #category : #accessing }
MidasAbstractApp >> context: aContext [
	context := aContext.
	aContext addListener: self.
	self updateStrong: aContext strongFocus
]

{ #category : #accessing }
MidasAbstractApp >> freeze [ 
	^ freeze 
]

{ #category : #initialization }
MidasAbstractApp >> initializeWidgets [
	freeze := (self instantiate: CheckBoxPresenter)
		label: 'Freeze content' ;
		yourself
]

{ #category : #accessing }
MidasAbstractApp >> mooseModel [
	^ context mooseModel
]

{ #category : #display }
MidasAbstractApp >> open [
	self openWithSpec
]

{ #category : #accessing }
MidasAbstractApp >> strongFocus [
	^ context strongFocus
]

{ #category : #notifications }
MidasAbstractApp >> updateStrong: focus [
	self subclassResponsibility
]

{ #category : #notifications }
MidasAbstractApp >> updateWeak: focus [
	self subclassResponsibility
]

{ #category : #accessing }
MidasAbstractApp >> weakFocus [
	^ context weakFocus
]
