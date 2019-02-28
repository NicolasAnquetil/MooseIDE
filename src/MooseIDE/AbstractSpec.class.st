Class {
	#name : #AbstractSpec,
	#superclass : #ComposablePresenter,
	#instVars : [
		'context'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #accessing }
AbstractSpec >> context [
	^ context
]

{ #category : #accessing }
AbstractSpec >> context: aContext [
	context := aContext.
	aContext addListener: self.
	self update: aContext 
]

{ #category : #accessing }
AbstractSpec >> mooseModel [
	^ context mooseModel
]

{ #category : #display }
AbstractSpec >> open [
	self openWithSpec
]

{ #category : #notifications }
AbstractSpec >> update: uiModel [
	
]
