"
An app showing source code of currently selected entity
"
Class {
	#name : #MidasAppEditor,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'code'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasAppEditor class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #chkFreeze
			withConstraints: [ :constraints | constraints height: 30 ];
		add: #code;
		yourself
]

{ #category : #accessing }
MidasAppEditor >> code [
	^ code
]

{ #category : #notifications }
MidasAppEditor >> displayFocus: aText [
	self updateTitle.
	code text: aText
]

{ #category : #initialization }
MidasAppEditor >> initializeWidgets [
	self canBeFrozen.
	code := self newText
]

{ #category : #api }
MidasAppEditor >> title [
	^ 'MIDAS Source: ''' , context midasFocus name , ''''
]
