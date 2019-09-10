"
I query models
"
Class {
	#name : #MidasQuery,
	#superclass : #Object,
	#instVars : [
		'masterModel'
	],
	#category : #'Midas-dashboardhelpers'
}

{ #category : #accessing }
MidasQuery >> displayName [
	self subclassResponsibility 
]

{ #category : #accessing }
MidasQuery >> entities [
	self subclassResponsibility 
]

{ #category : #accessing }
MidasQuery >> master: aGuiModel [
	masterModel := aGuiModel 
]
