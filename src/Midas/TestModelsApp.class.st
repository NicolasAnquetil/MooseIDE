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
TestModelsApp >> testModelListSortedByName [
	self
		assert:
			modelsApp lstModels items first name
				<= modelsApp lstModels items second name
]

{ #category : #tests }
TestModelsApp >> testUpdateModelInDashboard [
	| dashboardApp cachedDashboard |
	dashboardApp := launcherApp
		launch: MidasAppDashboard
		withContext: MidasContextDashboard.
	cachedDashboard := dashboardApp context strongFocus.
	modelsApp lstModels doubleClickAtIndex: 2.
	self deny: dashboardApp context strongFocus equals: cachedDashboard
]

{ #category : #tests }
TestModelsApp >> testUpdateModelInQuery [
	| queryApp cachedModel |
	queryApp := launcherApp
		launch: MidasAppQuery
		withContext: MidasContextQuery.
	cachedModel := queryApp context strongFocus.
	modelsApp lstModels doubleClickAtIndex: 2.
	self deny: queryApp context strongFocus equals: cachedModel.
	modelsApp lstModels doubleClickAtIndex: 1.
	self assert: queryApp context strongFocus equals: cachedModel
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
