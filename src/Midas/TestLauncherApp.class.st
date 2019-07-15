Class {
	#name : #TestLauncherApp,
	#superclass : #TestMidas,
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
	app := launcherApp launchQueryApp.
	self
		assert: launcherApp context children size
		equals: 1.
	app delete.
	self
		assert: launcherApp context children size
		equals: 0.

]

{ #category : #tests }
TestLauncherApp >> testQueryIsOnlyOpenedOnce [
	self assert: launcherApp context children size equals: 0.
	launcherApp launchQueryApp.
	launcherApp launchQueryApp.
	self assert: launcherApp context children size equals: 1
]

{ #category : #tests }
TestLauncherApp >> testUpdateModel [
	self
		assert: launcherApp lblModelName label
		equals: 'Current model: First-lanModel'.
	launcherApp context mooseModel: models second.
	self
		assert: launcherApp lblModelName label
		equals: 'Current model: Second-simpleModel'
]

{ #category : #tests }
TestLauncherApp >> testWindowTitle [
	self
		assert: launcherApp window title
		equals: 'MIDAS Launcher: First-lanModel'.
	launcherApp context mooseModel: models second.
	self
		assert: launcherApp window title
		equals: 'MIDAS Launcher: Second-simpleModel'.

]
