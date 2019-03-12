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
MidasAppQuery >> update: aContext [
	| newList |
	newList := self focus.
	(newList isKindOf: MooseModel)
		ifTrue: [ newList := newList mvsGroupEntitycache ].
	query initListViewItems: newList
]
