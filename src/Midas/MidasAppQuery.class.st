"
An app to select entities from the current model
"
Class {
	#name : #MidasAppQuery,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'query'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppQuery class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :c | 
			c
				add: #freeze height: 30;
				add: #query ];
		yourself
]

{ #category : #accessing }
MidasAppQuery >> context: aContext [
	super context: aContext.
	query subscribeTo: aContext
]

{ #category : #private }
MidasAppQuery >> delete [
	query delete.
	query := nil.
	super delete
]

{ #category : #initialization }
MidasAppQuery >> initializeWidgets [
	super initializeWidgets.
	query := self instantiate: MidasQueryAdapter.
	query parentApp: self
]

{ #category : #accessing }
MidasAppQuery >> query [ 
	^ query
]

{ #category : #api }
MidasAppQuery >> title [
	^'MIDAS Query' 
]

{ #category : #notifications }
MidasAppQuery >> updateStrongFocus: newFocus [
	query update
]

{ #category : #notifications }
MidasAppQuery >> updateWeakFocus: focus [
	query updateWeakFocus: focus

	
]
