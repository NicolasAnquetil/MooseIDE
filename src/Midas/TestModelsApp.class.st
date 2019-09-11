Class {
	#name : #TestModelsApp,
	#superclass : #TestMidasApp,
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
	self
		assert: launcherApp launchDashboardApp context midasFocus
		equals: models first
]

{ #category : #tests }
TestModelsApp >> testInitializeModelInListEntities [
	self
		assert: launcherApp launchEntitiesApp context midasFocus
		equals: models first
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
	modelsApp lstModels clickAtIndex: 2.
	self assert: dashboardApp context midasFocus equals: models second
]

{ #category : #tests }
TestModelsApp >> testUpdateModelInLauncher [
	modelsApp lstModels clickAtIndex: 2.
	self assert: launcherApp context midasFocus equals: models second
]

{ #category : #tests }
TestModelsApp >> testUpdateModelInQuery [
	| queryApp |
	queryApp := launcherApp launchEntitiesApp.
	modelsApp lstModels clickAtIndex: 2.
	self assert: queryApp context midasFocus equals: models second
]

{ #category : #tests }
TestModelsApp >> testUpdateModelOnClick [
	modelsApp lstModels clickAtIndex: 1.
	self
		assert: modelsApp mooseModel
		equals: modelsApp lstModels items first.
	modelsApp lstModels clickAtIndex: 2.
	self
		assert: modelsApp mooseModel
		equals: modelsApp lstModels items second
]
