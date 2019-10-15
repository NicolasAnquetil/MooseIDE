Class {
	#name : #TestCtxtEditor,
	#superclass : #AbstractTestMidasCtxt,
	#instVars : [
		'editorCtxt'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestCtxtEditor >> setUp [
	super setUp.
	editorCtxt := launcherCtxt spawn: MidasContextEditor.
	editorCtxt app: self mockEmptyApp.
]

{ #category : #tests }
TestCtxtEditor >> testFocusUpdateNoSource [
	| displayed |
	displayed := #().
	(mockApp stub displayFocus: Any) will: [:args | displayed := args].

	editorCtxt midasFocus: (MidasEntityCollection with: {#ancestor -> self someClasses}).

	self
		assert: displayed
		equals: editorCtxt entityHasNoSource.
]

{ #category : #tests }
TestCtxtEditor >> testFocusUpdateWithSource [
	| mockEntity displayed |
	displayed := #().
	(mockApp stub displayFocus: Any) will: [:args | displayed := args].

	mockEntity := Mock new.
	mockEntity stub hasSourceAnchor willReturn: true.
	mockEntity stub sourceText willReturn: 'The source code of this method'.

	editorCtxt midasFocus: (MidasEntityFamix with: mockEntity ancestor: #anAncestor).
	self
		assert: displayed
		equals: 'The source code of this method'.
]

{ #category : #tests }
TestCtxtEditor >> testModelUpdate [
	| displayed |
	displayed := #().
	(mockApp stub displayFocus: Any) will: [:args | displayed := args].

	editorCtxt midasFocus: (MidasEntityMooseModel with: models anyOne).

	self
		assert: displayed
		equals: editorCtxt modelHasNoSource
]
