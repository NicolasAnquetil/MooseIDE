Class {
	#name : #TestMidasGUI,
	#superclass : #TestCase,
	#instVars : [
		'launcher',
		'model',
		'dashboard',
		'query',
		'editor'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestMidasGUI >> setUp [
	launcher := MidasLauncher new.
	launcher openOnModel: MooseModel root allModels first.
	model := launcher
		launch: MidasAppModels
		withContext: MidasContextModels.
	dashboard := launcher
		launch: MidasAppDashboard
		withContext: MidasContextDashboard.
	query := launcher
		launch: MidasAppQuery
		withContext: MidasContextQuery.
	editor := launcher	launch: MidasAppEditor withContext: MidasContextEditor
]

{ #category : #running }
TestMidasGUI >> tearDown [
launcher exit
]
