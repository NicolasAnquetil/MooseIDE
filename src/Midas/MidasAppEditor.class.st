"
An app showing source code of currently selected entity
"
Class {
	#name : #MidasAppEditor,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'text'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppEditor class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :c | 
			c add: #text ];
		yourself
]

{ #category : #initialization }
MidasAppEditor >> initializeWidgets [
	text := self newText.
]

{ #category : #accessing }
MidasAppEditor >> text [
	^ text
]

{ #category : #api }
MidasAppEditor >> title [
	^ 'MIDAS Source Code'
]

{ #category : #notifications }
MidasAppEditor >> update: uiModel [
	text text: context focus sourceText
]
