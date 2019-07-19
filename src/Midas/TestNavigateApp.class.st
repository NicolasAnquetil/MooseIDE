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
TestNavigateApp >> testNavigateFromClass [
	| i |
	navigateApp context strongFocus: (models first allModelClasses detect: [:c | c name = 'Node']).
	i := navigateApp diagram items detectIndex: [ :item | item name = 'methods' ].
	navigateApp diagram doubleClickAtIndex: i.
	self
		assert: launcherApp strongFocus size
		equals: 14
]

{ #category : #tests }
TestNavigateApp >> testWindowTitle [
	self
		assert: navigateApp window title
		equals: 'MIDAS Navigate: ''First-lanModel'''.
	launcherApp context mooseModel: models second.
	self
		assert: navigateApp window title
		equals: 'MIDAS Navigate: ''Second-simpleModel'''
]
