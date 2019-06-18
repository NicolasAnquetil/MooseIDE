Class {
	#name : #TestMidasModelApp,
	#superclass : #TestCase,
	#instVars : [
		'modelContext',
		'launcherApp',
		'modelApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestMidasModelApp >> setUp [
	| models tmp |
	models := OrderedCollection new.
	tmp := Mock new.
	models
		add:
			(Mock new
				mockName: 'first';
				yourself).
	models
		add:
			(Mock new
				mockName: 'second';
				yourself).
	launcherApp := MidasLauncher new.
	launcherApp openOnModel: models first.
	modelApp := launcherApp launchModelsApp.
	modelApp lstModels items: models
]

{ #category : #running }
TestMidasModelApp >> tearDown [
	launcherApp exit
]

{ #category : #tests }
TestMidasModelApp >> testUpdateModelInQuery [
	| queryApp cachedModel |
	queryApp := launcherApp
		launch: MidasAppQuery
		withContext: MidasContextQuery.
	cachedModel := queryApp context strongFocus.
	modelApp lstModels doubleClickAtIndex: 2.
	self deny: queryApp context strongFocus equals: cachedModel.
	modelApp lstModels doubleClickAtIndex: 1.
	self assert: queryApp context strongFocus equals: cachedModel
]
