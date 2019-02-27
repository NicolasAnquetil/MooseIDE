Class {
	#name : #IDEDashboard,
	#superclass : #AbstractSpec,
	#instVars : [
		'dashboard'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #specs }
IDEDashboard class >> defaultSpec [
	^ SpecTableLayout column
		add: #dashboard
		yourself
]

{ #category : #accessing }
IDEDashboard >> context: aContext [
	super context: aContext.
	dashboard guiModel: aContext

]

{ #category : #accessing }
IDEDashboard >> dashboard [
	^ dashboard
]

{ #category : #initialization }
IDEDashboard >> initializeWidgets [
	dashboard := self instantiate: MDMetricDashBoard.

]

{ #category : #notifications }
IDEDashboard >> update: uiModel [
	dashboard updateViewFor: context
]
