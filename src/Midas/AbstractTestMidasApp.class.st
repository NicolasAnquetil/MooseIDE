Class {
	#name : #AbstractTestMidasApp,
	#superclass : #AbstractTestMidas,
	#instVars : [
		'launcherApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
AbstractTestMidasApp >> setUp [
	super setUp.
	launcherApp := MidasLauncher new.
	launcherApp openOnModel: models first.
]

{ #category : #running }
AbstractTestMidasApp >> tearDown [
	launcherApp ifNotNil: [launcherApp exit]
]
