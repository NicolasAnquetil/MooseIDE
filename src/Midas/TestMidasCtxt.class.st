Class {
	#name : #TestMidasCtxt,
	#superclass : #TestMidas,
	#instVars : [
		'launcherCtxt',
		'mockApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestMidasCtxt >> mockEmptyApp [
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
	launcherCtxt initializeMooseModel: models first.
]
