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
	
	query := self instantiate: MVSMainPresenter
		
]

{ #category : #accessing }
IDEQuery >> query [ 
	^ query
]

{ #category : #notifications }
IDEQuery >> update: aContext [
	query initListViewItems: aContext focus
]
