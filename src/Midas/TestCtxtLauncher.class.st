Class {
	#name : #TestCtxtLauncher,
	#superclass : #TestMidasCtxt,
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestCtxtLauncher >> testMooseModel [
	self assert: launcherCtxt mooseModel equals: models first.

]
