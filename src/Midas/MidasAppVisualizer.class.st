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
		newColumn: [ :c | 
			c
				add: #freeze height: 30;
				add: #visualizer ];
		yourself
]

{ #category : #initialization }
MidasAppVisualizer >> initializeWidgets [
	super initializeWidgets.
	visualizer := self instantiate: MVSSystemComplexityPresenter
]

{ #category : #api }
MidasAppVisualizer >> title [
	^ 'MIDAS Visualizer'
]

{ #category : #notifications }
MidasAppVisualizer >> updateStrong: focus [
	visualizer selected: focus.
	visualizer refresh
]

{ #category : #notifications }
MidasAppVisualizer >> updateWeak: focus [
	self updateStrong: focus
]

{ #category : #accessing }
MidasAppVisualizer >> visualizer [
	^ visualizer 
]
