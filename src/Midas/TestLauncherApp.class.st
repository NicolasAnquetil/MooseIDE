Class {
	#name : #TestLauncherApp,
	#superclass : #TestMidasApp,
	#category : #'Midas-Tests'
}

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
TestLauncherApp >> testWindowTitle [
	self
		assert: launcherApp window title
		equals: 'MIDAS ''Model: First-lanModel'''.
	launcherApp context mooseModel: (MidasEntityMooseModel with: models second).
	self
		assert: launcherApp window title
		equals: 'MIDAS ''Model: Second-simpleModel'''.

]
