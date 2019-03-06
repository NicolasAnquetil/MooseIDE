"
An app showing a visualization on the current model or selected entity-ies
"
Class {
	#name : #MidasAppVisualizer,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'visualizer'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppVisualizer class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :c | c add: #visualizer ];
		yourself
]

{ #category : #initialization }
MidasAppVisualizer >> initializeWidgets [
	visualizer := self instantiate: MVSSystemComplexityPresenter
]

{ #category : #notifications }
MidasAppVisualizer >> update: uiModel [
	visualizer selected: context focus.
	visualizer refresh
]

{ #category : #accessing }
MidasAppVisualizer >> visualizer [
	^ visualizer 
]
