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
	^ SpecBoxLayout newVertical
				add: #freeze withConstraints: [ :constraints | constraints height: 30 ];
				add: #dashboard ;
		yourself
]

{ #category : #accessing }
MidasAppDashboard >> context: aContext [
	"need to do this first because setting the context will try to update the view
	 and dashboard needs guiModel to update itself"

	dashboard guiModel: aContext.
	super context: aContext
]

{ #category : #accessing }
MidasAppDashboard >> dashboard [
^dashboard
]

{ #category : #accessing }
MidasAppDashboard >> dashboardMetric: anInt [
	^ anInt == 1
		ifTrue: [ dashboard firstMetric allValues ]
		ifFalse: [ anInt == 2
				ifTrue: [ dashboard secondMetric allValues ]
				ifFalse: [ anInt == 3
						ifTrue: [ dashboard thirdMetric allValues ]
						ifFalse: [ nil ] ] ]
]

{ #category : #initialization }
MidasAppDashboard >> initializePresenter [
	dashboard whenMainMetricIsClick: [ self selectMainMetricValue ].
	dashboard whenSubMetricsIsClick: [:value| self selectSubMetricValue: value]
]

{ #category : #initialization }
MidasAppDashboard >> initializeWidgets [
	super initializeWidgets.
	dashboard := self instantiate: MDMetricDashBoard
]

{ #category : #initialization }
MidasAppDashboard >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 750 @ 180.
]

{ #category : #action }
MidasAppDashboard >> selectMainMetricValue [
	context selectedStrongFocus: context focusedEntities
]

{ #category : #action }
MidasAppDashboard >> selectSubMetricValue: aNumber [
	context selectedStrongFocus: (context  subQuery: aNumber) entities
]

{ #category : #api }
MidasAppDashboard >> title [
	^'MIDAS Dashboard: ' , context modelName 
]

{ #category : #notifications }
MidasAppDashboard >> updateModel: aMooseModel [
	self updateTitle.
	self updateStrongFocus: aMooseModel allModelClasses.
		
]

{ #category : #notifications }
MidasAppDashboard >> updateStrongFocus: newFocus [
	dashboard updateView
]

{ #category : #notifications }
MidasAppDashboard >> updateWeakFocus: newFocus [
	self shouldNotImplement 

	
]
