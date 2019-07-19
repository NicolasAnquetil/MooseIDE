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
	^ 	navigateApp diagram items
			detectIndex: [ :item | item name beginsWith: aString ]
			 ifNone: [ 0 ].

]

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
TestNavigateApp >> testSelectAllModelClasses [
	navigateApp diagram doubleClickAtIndex: (self indexFor: #allModelClasses).
	self assert: navigateApp context strongFocus size equals: 6
]

{ #category : #tests }
TestNavigateApp >> testSelectAllModelPackages [
	navigateApp diagram doubleClickAtIndex: (self indexFor: #allModelPackages).
	self assert: navigateApp context strongFocus size equals: 1
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
