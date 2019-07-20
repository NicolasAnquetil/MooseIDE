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

{ #category : #running }
TestMidas >> someAttributes [
	^models first allAttributes 
]

{ #category : #running }
TestMidas >> someClasses [
	^models first allModelClasses 
]

{ #category : #running }
TestMidas >> someMethods [
	^models first allModelMethods 
]

{ #category : #running }
TestMidas >> someNamespaces [
	^models first allModelNamespaces
]

{ #category : #running }
TestMidas >> somePackages [
	^models first allModelPackages 
]
