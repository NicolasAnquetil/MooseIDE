Class {
	#name : #TestMidasLauncher,
	#superclass : #TestMidas,
	#category : #'Midas-Tests'
}

{ #category : #running }
TestMidasLauncher >> setUp [
	super setUp.

]

{ #category : #tests }
TestMidasLauncher >> testWindowTitle [
	self assert: launcher window title equals: models first name.
]
