"
An app to select entities from the current model
"
Class {
	#name : #IDEQuery,
	#superclass : #AbstractSpec,
	#instVars : [
		'query'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #specs }
IDEQuery class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :c | c add: #query ];
		yourself
]

{ #category : #initialization }
IDEQuery >> initializeWidgets [
	query := self instantiate: IDESubQuery.
	query parentApp: self.
		
]

{ #category : #accessing }
IDEQuery >> query [ 
	^ query
]

{ #category : #api }
IDEQuery >> title [
	^'MIDAS Query' 
]

{ #category : #notifications }
IDEQuery >> update: aContext [
	| newList |
	newList := context focus.
	(newList isKindOf: MooseModel)
	ifTrue: [ newList := newList mvsGroupEntitycache ].
	query initListViewItems: newList 
	
]
