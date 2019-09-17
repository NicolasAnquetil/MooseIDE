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
	modelsApp context allModels: models.

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
TestModelsApp >> testUpdateModelOnClick [
	|  mockCtxt userSelection |
	mockCtxt := Mock new.
	(mockCtxt stub userSelection: Any) will: [:arg | userSelection := arg].
	modelsApp context: mockCtxt.

	modelsApp lstModels clickAtIndex: 1.
	self assert: userSelection equals: 1.
	modelsApp lstModels clickAtIndex: 2.
	self assert: userSelection equals: 2

]
