"
An app showing some metric values on the current model 

"
Class {
	#name : #MidasAppDashboard,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'dashboard'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppDashboard class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :c | 
			c
				add: #freeze height: 30;
				add: #dashboard ];
		yourself
]

{ #category : #accessing }
MidasAppDashboard >> context: aContext [
	"need to do this first because setting the context will try to update the view
	 and dashboard needs guiModel to update itself"
	dashboard guiModel: aContext.
	super context: aContext.

]

{ #category : #accessing }
MidasAppDashboard >> dashboard [
	^ dashboard
]

{ #category : #api }
MidasAppDashboard >> extent [
	^ 630 @ 170
]

{ #category : #initialization }
MidasAppDashboard >> initializeWidgets [
	super initializeWidgets.
	dashboard := self instantiate: MDMetricDashBoard
]

{ #category : #api }
MidasAppDashboard >> title [
	^'MIDAS Dashboard' 
]

{ #category : #notifications }
MidasAppDashboard >> updateStrongFocus: newFocus [
	dashboard updateView
]

{ #category : #notifications }
MidasAppDashboard >> updateWeakFocus: newFocus [
	self shouldNotImplement 

	
]
