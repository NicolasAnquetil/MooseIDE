"
An app showing source code of currently selected entity
"
Class {
	#name : #MidasAppEditor,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'code'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppEditor class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :c | 
			c
				add: #freeze height: 30;
				add: #code ];
		yourself
]

{ #category : #accessing }
MidasAppEditor >> code [
	^ code
]

{ #category : #initialization }
MidasAppEditor >> initializeWidgets [
	super initializeWidgets.
	code := self newText
]

{ #category : #api }
MidasAppEditor >> title [
	^ 'MIDAS Source Code'
]

{ #category : #notifications }
MidasAppEditor >> updateStrong: focus [
	self updateWeak: focus
]

{ #category : #notifications }
MidasAppEditor >> updateWeak: focus [
	(focus isKindOf: FAMIXSourcedEntity)
	ifTrue: [code text: focus sourceText]
	
]
