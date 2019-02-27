Class {
	#name : #AppContextLauncher,
	#superclass : #AppContextOptionalFocus,
	#instVars : [
		'mooseModel'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #accessing }
AppContextLauncher >> mooseModel [
	^ mooseModel
]

{ #category : #accessing }
AppContextLauncher >> mooseModel: anObject [
	mooseModel := anObject
]
