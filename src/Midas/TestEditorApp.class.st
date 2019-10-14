Class {
	#name : #TestEditorApp,
	#superclass : #AbstractTestMidasApp,
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

{ #category : #tests }
TestEditorApp >> testFocusUpdateNoSource [
	editorApp context midasFocus: (MidasEntityFamixCollection with: {#ancestor -> self someClasses}).
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''2 entities'''.

]

{ #category : #tests }
TestEditorApp >> testFocusUpdateWithSource [
	| method |
	method := self someMethods anyOne.

	editorApp context midasFocus: (MidasEntityFamix with: method ancestor: #anAncestor).
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''', method name , ''''.

]

{ #category : #tests }
TestEditorApp >> testModelUpdate [
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''First-lanModel'''.

	launcherApp context mooseModel: (MidasEntityMooseModel with: models second).
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''Second-simpleModel'''.

]
