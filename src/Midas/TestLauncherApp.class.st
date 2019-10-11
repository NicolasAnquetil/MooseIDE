Class {
	#name : #TestLauncherApp,
	#superclass : #AbstractTestMidasApp,
	#category : #'Midas-Tests'
}

{ #category : #accessing }
TestLauncherApp >> appAt: anInteger [
	^launcherApp menu menuGroups first menuItems at: anInteger
]

{ #category : #tests }
TestLauncherApp >> testCloseDashboard [
	| app |
	self
		assert: launcherApp context children size
		equals: 0.
	app := launcherApp launchDashboardApp.
	self
		assert: launcherApp context children size
		equals: 1.
	app delete.
	self
		assert: launcherApp context children size
		equals: 0.

]

{ #category : #tests }
TestLauncherApp >> testCloseEditor [
	| app |
	self
		assert: launcherApp context children size
		equals: 0.
	app := launcherApp launchEditorApp.
	self
		assert: launcherApp context children size
		equals: 1.
	app delete.
	self
		assert: launcherApp context children size
		equals: 0.

]

{ #category : #tests }
TestLauncherApp >> testCloseModels [
	| app |
	self
		assert: launcherApp context children size
		equals: 0.
	app := launcherApp launchModelsApp.
	self
		assert: launcherApp context children size
		equals: 1.
	app delete.
	self
		assert: launcherApp context children size
		equals: 0.

]

{ #category : #tests }
TestLauncherApp >> testCloseQuery [
	| app |
	self
		assert: launcherApp context children size
		equals: 0.
	app := launcherApp launchEntitiesApp.
	self
		assert: launcherApp context children size
		equals: 1.
	app delete.
	self
		assert: launcherApp context children size
		equals: 0.

]

{ #category : #tests }
TestLauncherApp >> testDisabledAppsWithoutModel [
	| mockCtxt |
	self skip.

	mockCtxt := Mock new.
	mockCtxt stub modelName willReturn: #whatever.
	mockCtxt stub mooseModel willReturn: nil.
	
	"create a new launcher without model"
	launcherApp exit.
	launcherApp := MidasLauncher open.
	launcherApp context: mockCtxt.

	self assert: (self appAt: 1) isEnabled.
	self deny: (self appAt: 2) isEnabled.

	launcherApp updateModel: mockCtxt.
	self assert: (self appAt: 1) isEnabled.
	self assert: (self appAt: 2) isEnabled.

]

{ #category : #tests }
TestLauncherApp >> testWindowTitle [
	self
		assert: launcherApp window title
		equals: 'MIDAS ''Model: First-lanModel'''.
	launcherApp context mooseModel: (MidasEntityMooseModel with: models second).
	self
		assert: launcherApp window title
		equals: 'MIDAS ''Model: Second-simpleModel'''.

]
