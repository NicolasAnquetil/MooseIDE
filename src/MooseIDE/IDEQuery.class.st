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
	^ SpecTableLayout column
		add: #query
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
	query initListViewItems: aContext focus
]
