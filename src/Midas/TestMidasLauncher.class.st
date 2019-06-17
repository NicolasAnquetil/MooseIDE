Class {
	#name : #TestMidasLauncher,
	#superclass : #TestMidasGUI,
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestMidasLauncher >> testWindowTitle [
	self
		assert: launcher window title
		equals: MooseModel root allModels first name
]
