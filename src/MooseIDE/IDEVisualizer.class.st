"
An app showing a visualization on the current model or selected entity-ies
"
Class {
	#name : #IDEVisualizer,
	#superclass : #AbstractSpec,
	#instVars : [
		'visualizer'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #specs }
IDEVisualizer class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :c | c add: #visualizer ];
		yourself
]

{ #category : #initialization }
IDEVisualizer >> initializeWidgets [
	visualizer := self instantiate: MVSSystemComplexityPresenter
]

{ #category : #notifications }
IDEVisualizer >> update: uiModel [
	visualizer selected: context focus.
	visualizer refresh
]

{ #category : #accessing }
IDEVisualizer >> visualizer [
	^ visualizer 
]
