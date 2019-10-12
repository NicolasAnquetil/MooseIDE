"
An app showing some metric values on the current model 

"
Class {
	#name : #MidasAppDashboard,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'metric1',
		'metric2',
		'metric3'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasAppDashboard class >> defaultSpec [
	^ SpBoxLayout newVertical
				add: #chkFreeze withConstraints: [ :constraints | constraints height: 30 ];
				add:
					(SpBoxLayout newHorizontal
						add: #metric1;
						add: #metric2;
						add: #metric3 ;
						yourself
					) ;
		yourself
]

{ #category : #accessing }
MidasAppDashboard >> context: aContext [
	"need to do this first because setting the context will try to update the view
	 and dashboard needs guiModel to update itself"

	metric1 guiModel: aContext.
	metric2 guiModel: aContext.
	metric3 guiModel: aContext.
	super context: aContext
]

{ #category : #accessing }
MidasAppDashboard >> dashboardMetric: anInt [
	^ anInt == 1
		ifTrue: [ self metric1 allValues ]
		ifFalse: [ anInt == 2
				ifTrue: [ self metric2 allValues ]
				ifFalse: [ anInt == 3
						ifTrue: [ self metric3 allValues ]
						ifFalse: [ nil ] ] ]
]

{ #category : #notifications }
MidasAppDashboard >> displayFocus: newFocus [
	metric1 update.
	metric2 update.
	metric3 update.

]

{ #category : #notifications }
MidasAppDashboard >> displayModel: aMooseModel [
	super displayModel: aMooseModel.
	self displayFocus: aMooseModel allModelClasses.
		
]

{ #category : #initialization }
MidasAppDashboard >> initializeMetricWidget: anInt [
	^ (self instantiate: MidasMetricPresenter)
			id: anInt ;
			yourself
]

{ #category : #initialization }
MidasAppDashboard >> initializeWidgets [
	self canBeFrozen.
	metric1 := self initializeMetricWidget: 1.
	metric2 := self initializeMetricWidget: 2.
	metric3 := self initializeMetricWidget: 3
]

{ #category : #initialization }
MidasAppDashboard >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: self windowExtent
]

{ #category : #accessing }
MidasAppDashboard >> metric1 [
	^ metric1
]

{ #category : #accessing }
MidasAppDashboard >> metric2 [
	^ metric2
]

{ #category : #accessing }
MidasAppDashboard >> metric3 [
	^ metric3
]

{ #category : #api }
MidasAppDashboard >> title [
	^'Dashboard ''' , context modelName , ''''
]

{ #category : #initialization }
MidasAppDashboard >> windowExtent [
	^ 350 @ 140
]
