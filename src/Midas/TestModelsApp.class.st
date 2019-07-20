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
		assert: launcherApp launchDashboardApp context strongFocus
		equals: models first
]

{ #category : #tests }
TestModelsApp >> testInitializeModelInListEntities [
	self
		assert: launcherApp launchEntitiesApp context strongFocus
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
	modelsApp lstModels doubleClickAtIndex: 2.
	self assert: dashboardApp context strongFocus equals: models second
]

{ #category : #tests }
TestModelsApp >> testUpdateModelInLauncher [
	modelsApp lstModels doubleClickAtIndex: 2.
	self assert: launcherApp context strongFocus equals: models second
]

{ #category : #tests }
TestModelsApp >> testUpdateModelInQuery [
	| queryApp |
	queryApp := launcherApp launchEntitiesApp.
	modelsApp lstModels doubleClickAtIndex: 2.
	self assert: queryApp context strongFocus equals: models second
]

{ #category : #tests }
TestModelsApp >> testUpdateModelOnDoubleClick [
	modelsApp lstModels doubleClickAtIndex: 1.
	self
		assert: modelsApp mooseModel
		equals: modelsApp lstModels items first.
	modelsApp lstModels doubleClickAtIndex: 2.
	self
		assert: modelsApp mooseModel
		equals: modelsApp lstModels items second
]
