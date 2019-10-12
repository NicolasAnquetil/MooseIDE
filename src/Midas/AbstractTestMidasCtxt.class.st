Class {
	#name : #AbstractTestMidasCtxt,
	#superclass : #AbstractTestMidas,
	#instVars : [
		'launcherCtxt',
		'mockApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
AbstractTestMidasCtxt >> mockEmptyApp [
	mockApp := Mock new.
	mockApp stub displayModel: nil.
	mockApp stub displayFocus: nil.
	^ mockApp

]

{ #category : #running }
AbstractTestMidasCtxt >> setUp [
	super setUp.
	launcherCtxt := MidasContextLauncher new.
	launcherCtxt app: self mockEmptyApp.
	launcherCtxt initializeMooseModel: models second.
]
