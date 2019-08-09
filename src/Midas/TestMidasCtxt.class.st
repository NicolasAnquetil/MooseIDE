Class {
	#name : #TestMidasCtxt,
	#superclass : #TestMidas,
	#instVars : [
		'launcherCtxt'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestMidasCtxt >> mockEmptyApp [
	| mockApp |
	mockApp := Mock new.
	mockApp stub updateModel: nil.
	mockApp stub updateMidasFocus: nil.
	^ mockApp

]

{ #category : #running }
TestMidasCtxt >> setUp [
	super setUp.
	launcherCtxt := MidasContextLauncher new.
	launcherCtxt app: self mockEmptyApp.
	launcherCtxt mooseModel: models first.
]
