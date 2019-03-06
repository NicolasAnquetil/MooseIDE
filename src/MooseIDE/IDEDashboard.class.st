"
An app showing some metric values on the current model 

"
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
	^ SpecLayout composed
		newColumn: [ :c | c add: #dashboard ];
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

{ #category : #api }
IDEDashboard >> extent [
	^630 @ 130
]

{ #category : #initialization }
IDEDashboard >> initializeWidgets [
	dashboard := self instantiate: MDMetricDashBoard.

]

{ #category : #api }
IDEDashboard >> title [
	^'MIDAS Dashboard' 
]

{ #category : #notifications }
IDEDashboard >> update: uiModel [
	dashboard updateView
]
