Class {
	#name : #IDEEditor,
	#superclass : #AbstractSpec,
	#instVars : [
		'text'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #specs }
IDEEditor class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :c | 
			c add: #text ];
		yourself
]

{ #category : #initialization }
IDEEditor >> initializeWidgets [
	text := self newText.
]

{ #category : #accessing }
IDEEditor >> text [
	^ text
]

{ #category : #api }
IDEEditor >> title [
	^ 'MIDAS Source Code'
]

{ #category : #notifications }
IDEEditor >> update: uiModel [
	text text: context focus sourceText
]
