Class {
	#name : #TestCtxtModels,
	#superclass : #AbstractTestMidasCtxt,
	#instVars : [
		'modelsCtxt'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestCtxtModels >> setUp [
	super setUp.
	modelsCtxt := launcherCtxt spawn: MidasContextModels.
	modelsCtxt allModels: models.
	modelsCtxt app: self mockEmptyApp.
]

{ #category : #tests }
TestCtxtModels >> testInitializeModelInOtherApp [
	| otherCtxt |
	otherCtxt := launcherCtxt spawn: MidasContextEditor.
	self assert: (otherCtxt midasFocus sameModel: models second)
]

{ #category : #tests }
TestCtxtModels >> testModelSelection [
	modelsCtxt userSelection: 2.
	self assert: (modelsCtxt midasFocus sameModel: models second)
]

{ #category : #tests }
TestCtxtModels >> testUpdateModelInOtherApp [
	| otherCtxt |
	otherCtxt := launcherCtxt spawn: MidasContextEditor.
	otherCtxt app: self mockEmptyApp.
	modelsCtxt userSelection: 2.
	self assert: (otherCtxt midasFocus sameModel: models second)
]
