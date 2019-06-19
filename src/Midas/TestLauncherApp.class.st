Class {
	#name : #TestLauncherApp,
	#superclass : #TestMidas,
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestLauncherApp >> testWindowTitle [
	self assert: launcherApp window title equals: self mooseModels first name
]
