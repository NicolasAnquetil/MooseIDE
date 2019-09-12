Class {
	#name : #TestNavigateApp,
	#superclass : #TestMidasApp,
	#instVars : [
		'navigateApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestNavigateApp >> indexFor: aString [
	^ 	navigateApp properties items
			detectIndex: [ :item | item name beginsWith: aString ]
			 ifNone: [ 0 ].

]

{ #category : #running }
TestNavigateApp >> setUp [
	super setUp.
	navigateApp := launcherApp launchNavigateApp
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
