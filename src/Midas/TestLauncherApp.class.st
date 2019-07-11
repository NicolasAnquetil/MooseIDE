Class {
	#name : #TestLauncherApp,
	#superclass : #TestMidas,
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestLauncherApp >> testWindowTitle [
	self
		assert: launcherApp window title
		equals: 'MIDAS Launcher: First-lanModel'.
	launcherApp context mooseModel: models second.
	self
		assert: launcherApp window title
		equals: 'MIDAS Launcher: Second-simpleModel'.

]
