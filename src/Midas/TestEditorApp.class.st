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
	editorApp context midasFocus: self someClasses.
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''All model classes'''.
	self
		assert: editorApp code text
		equals: editorApp entityHasNoSource.
]

{ #category : #tests }
TestEditorApp >> testFocusUpdateWithSource [
	| method |
	method := self someMethods anyOne.
	method sourceAnchor:
		(FamixStSourceTextAnchor new
			source: 'The source code of this method';
			yourself).

	editorApp context midasFocus: method.
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''', method name , ''''.
	self
		assert: editorApp code text
		equals: 'The source code of this method'.
]

{ #category : #tests }
TestEditorApp >> testModelUpdate [
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''First-lanModel'''.
	launcherApp context mooseModel: models second.
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''Second-simpleModel'''.
	self
		assert: editorApp code text
		equals: editorApp modelHasNoSource
]
