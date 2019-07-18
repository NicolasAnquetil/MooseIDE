Class {
	#name : #TestEditorApp,
	#superclass : #TestMidasApp,
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
				source: 'The source code of this method';
				yourself).

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

{ #category : #tests }
TestEditorApp >> testStrongFocusUpdateNoSource [
	editorApp context strongFocus: models first allModelClasses.
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''All model classes'''.
	self
		assert: editorApp code text
		equals: editorApp entityHasNoSource.
]

{ #category : #tests }
TestEditorApp >> testStrongFocusUpdateWithSource [
	| method |
	method := models first allMethods detect: [:m | m sourceText isNotNil ].
	editorApp context strongFocus: method.
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''', method name , ''''.
	self
		assert: editorApp code text
		equals: 'The source code of this method'.
]

{ #category : #tests }
TestEditorApp >> testWeakFocusUpdateNoSource [
	editorApp context weakFocus: models first allModelClasses.
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''All model classes'''.
	self
		assert: editorApp code text
		equals: editorApp entityHasNoSource.
]

{ #category : #tests }
TestEditorApp >> testWeakFocusUpdateWithSource [
	| method |
	method := models first allMethods detect: [:m | m sourceText isNotNil ].
	editorApp context weakFocus: method.
	self
		assert: editorApp window title
		equals: 'MIDAS Source: ''', method name , ''''.
	self
		assert: editorApp code text
		equals: 'The source code of this method'.
]
