Class {
	#name : #TestModelsApp,
	#superclass : #AbstractTestMidasApp,
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

	"Need to call #allmodels again."
	modelsApp displayModel: models first
]

{ #category : #tests }
TestModelsApp >> testClearSelection [
	| mockCtxt |
	mockCtxt := Mock new.
	modelsApp context: mockCtxt.

	modelsApp lstModels selectPropertyAtIndex: 1.
	self assert: modelsApp selectedIndexes size equals: 1.

	modelsApp displayModel: #whatever.

	self assert: modelsApp selectedIndexes size equals: 0
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

	modelsApp lstModels selectPropertyAtIndex: 1.
	self assert: userSelection equals: 1.
	modelsApp lstModels selectPropertyAtIndex: 2.
	self assert: userSelection equals: 2

]
