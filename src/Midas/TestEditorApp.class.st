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
	
	models first allMethods first
		sourceAnchor:
			(FamixStSourceTextAnchor new
				source: 'blah blah some text';
				yourself)
				
	"self halt.
	editorApp mooseModel allMethods second sourceText"
]

{ #category : #tests }
TestEditorApp >> testTest [
	self fail
]
