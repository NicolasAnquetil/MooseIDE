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

	self title: self class name asString , ': ' , aContext currentEntity name.

]

{ #category : #accessing }
AbstractSpec >> currentEntity [
	^ context currentEntity
]

{ #category : #running }
AbstractSpec >> launch: anAppClass on: anEntity [
	anAppClass new
		context: (self newContextWith: anEntity) ;
		open
]

{ #category : #accessing }
AbstractSpec >> model [
	^ context model
]

{ #category : #running }
AbstractSpec >> newContextWith: anEntity [
	^ AppContext new
			parentContext: self context ;
			currentEntity: anEntity ;
			yourself
]

{ #category : #display }
AbstractSpec >> open [
	self openWithSpec
]
