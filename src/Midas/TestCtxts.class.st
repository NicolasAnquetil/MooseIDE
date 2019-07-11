Class {
	#name : #TestCtxts,
	#superclass : #TestCase,
	#instVars : [
		'mooseModel',
		'ctxt'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestCtxts >> setUp [
	mooseModel := MooseModel importFromMSEStream: (TestMidas lanModel readStream)
]
