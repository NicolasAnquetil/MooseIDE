Class {
	#name : #TestModelsApp,
	#superclass : #TestMidas,
	#instVars : [
		'modelsApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestModelsApp >> setUp [
	super setUp.
	modelsApp := launcherApp launchModelsApp.
	modelsApp context stub allModels willReturn: models.

	"Need to call [allmodels] again."
	modelsApp updateModel: models first
]

{ #category : #tests }
TestModelsApp >> testInitializeModelInDashboard [
	| dashboardApp |
	dashboardApp := launcherApp launchDashboardApp.
	self assert: dashboardApp context strongFocus equals: models first
]

{ #category : #tests }
TestModelsApp >> testInitializeModelInQuery [
	| queryApp |
	queryApp := launcherApp launchQueryApp.
	self assert: queryApp context strongFocus equals: models first
]

{ #category : #tests }
TestModelsApp >> testModelListSortedByName [
	self
		assert:
			modelsApp lstModels items first name
				<= modelsApp lstModels items second name
]

{ #category : #tests }
TestModelsApp >> testUpdateModelInDashboard [
	| dashboardApp |
	dashboardApp := launcherApp launchDashboardApp.
	modelsApp lstModels doubleClickAtIndex: 2.
	self assert: dashboardApp context strongFocus equals: models second
]

{ #category : #tests }
TestModelsApp >> testUpdateModelInLauncher [
	modelsApp lstModels doubleClickAtIndex: 2.
	self
		assert: launcherApp window title
		equals: 'MIDAS Launcher: ''Second-simpleModel'''
]

{ #category : #tests }
TestModelsApp >> testUpdateModelInQuery [
	| queryApp |
	queryApp := launcherApp launchQueryApp.
	modelsApp lstModels doubleClickAtIndex: 2.
	self assert: queryApp context strongFocus equals: models second
]

{ #category : #tests }
TestModelsApp >> testUpdateModelWhenTheItemIsDoubleClicked [
	modelsApp lstModels doubleClickAtIndex: 1.
	self
		assert: modelsApp mooseModel
		equals: modelsApp lstModels items first.
	modelsApp lstModels doubleClickAtIndex: 2.
	self
		assert: modelsApp mooseModel
		equals: modelsApp lstModels items second
]
