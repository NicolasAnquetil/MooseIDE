Class {
	#name : #TestMidas,
	#superclass : #TestCase,
	#instVars : [
		'models'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestMidas >> setUp [
	models := OrderedCollection new.
	models
		add: (MooseModel importFromMSEStream: TestMidasApp lanModel readStream);
		add: (MooseModel importFromMSEStream: TestMidasApp simpleModel readStream).
	models first  cacheMooseGroups ; name: 'First-lanModel'.
	models second cacheMooseGroups ; name: 'Second-simpleModel'.
]
