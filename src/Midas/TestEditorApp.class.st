Class {
	#name : #TestEditorApp,
	#superclass : #TestMidas,
	#instVars : [
		'editorApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestEditorApp >> setUp [
	super setUp.
	editorApp := launcherApp launchEditorApp.
]
