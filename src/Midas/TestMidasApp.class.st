Class {
	#name : #TestMidasApp,
	#superclass : #TestMidas,
	#instVars : [
		'launcherApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestMidasApp >> setUp [
	super setUp.
	launcherApp := MidasLauncher new.
	launcherApp openOnModel: models first.
]

{ #category : #running }
TestMidasApp >> tearDown [
	launcherApp ifNotNil: [launcherApp exit]
]
