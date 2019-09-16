Class {
	#name : #TestNavigateApp,
	#superclass : #TestMidasApp,
	#instVars : [
		'navigateApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestNavigateApp >> setUp [
	super setUp.
	navigateApp := launcherApp launchNavigateApp
]

{ #category : #tests }
TestNavigateApp >> testWindowTitle [
	self
		assert: navigateApp window title
		equals: 'Navigate ''Model: First-lanModel'''.
	launcherApp context mooseModel: models second.
	self
		assert: navigateApp window title
		equals: 'Navigate ''Model: Second-simpleModel'''
]
