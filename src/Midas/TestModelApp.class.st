Class {
	#name : #TestModelApp,
	#superclass : #TestMidas,
	#instVars : [
		'modelApp',
		'modelContext'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestModelApp >> setUp [
	super setUp.
	modelApp := launcherApp launchModelsApp.
	modelApp context stub allModels willReturn: models.
	
	"Need to call [allmodels] again."
	modelApp updateModel: models first
]

{ #category : #tests }
TestModelApp >> testModelListSortedByName [
	self
		assert:
			modelApp lstModels items first name
				<= modelApp lstModels items second name
]

{ #category : #tests }
TestModelApp >> testUpdateModelInDashboard [
	| dashboardApp cachedDashboard |
	dashboardApp := launcherApp
		launch: MidasAppDashboard
		withContext: MidasContextDashboard.
	cachedDashboard := dashboardApp context strongFocus.
	modelApp lstModels doubleClickAtIndex: 2.
	self deny: dashboardApp context strongFocus equals: cachedDashboard.
	
]

{ #category : #tests }
TestModelApp >> testUpdateModelInQuery [
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

{ #category : #tests }
TestModelApp >> testUpdateModelWhenTheItemIsDoubleClicked [
	modelApp lstModels doubleClickAtIndex: 1.
	self
		assert: modelApp mooseModel
		equals: modelApp lstModels items first.
	modelApp lstModels doubleClickAtIndex: 2.
	self
		assert: modelApp mooseModel
		equals: modelApp lstModels items second
]
