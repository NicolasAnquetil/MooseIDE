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
	"need to do this first because setting the context will try to update the view
	 and dashboard needs guiModel to update itself"
	dashboard guiModel: aContext.
	super context: aContext.

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
