Class {
	#name : #MidasAppQuery,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'queryPresenter'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasAppQuery class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #queryPresenter
		yourself
]

{ #category : #notifications }
MidasAppQuery >> displayFocus: focus [
	queryPresenter displayFocus: focus
]

{ #category : #delegated }
MidasAppQuery >> fldQuery [
	^queryPresenter fldQuery text
]

{ #category : #delegated }
MidasAppQuery >> fldQuery: aString [
	queryPresenter fldQuery text: aString
]

{ #category : #initialization }
MidasAppQuery >> initializeWidgets [
	queryPresenter := self instantiate: MidasPresenterQuery 
]

{ #category : #delegated }
MidasAppQuery >> interpretQuery: aString [
	^context interpretQuery: aString
]

{ #category : #accessing }
MidasAppQuery >> mnuSelcolSelect: anInt [
	^queryPresenter mnuSelcolSelect: anInt
]

{ #category : #delegated }
MidasAppQuery >> navigationProperties [
	^context navigationProperties
]

{ #category : #delegated }
MidasAppQuery >> queryIsFilter: aBoolean [
	^context queryIsFilter: aBoolean
]

{ #category : #delegated }
MidasAppQuery >> selectPropertyAtIndex: anInt [
	queryPresenter selectPropertyAtIndex: anInt
]

{ #category : #accessing }
MidasAppQuery >> selectedItems [
	^queryPresenter selectedItems
]

{ #category : #initialization }
MidasAppQuery >> title [
	^'Navigate ''' , context modelName , ''''
]

{ #category : #delegated }
MidasAppQuery >> userSelection: aSelection [
	^context userSelection: aSelection
]
