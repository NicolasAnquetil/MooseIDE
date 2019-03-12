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
	visualizer := self instantiate: MidasSystemComplexityAdapter	"MVSSystemComplexityPresenter".
	visualizer parentApp: self
]

{ #category : #api }
MidasAppVisualizer >> title [
	^ 'MIDAS Visualizer'
]

{ #category : #notifications }
MidasAppVisualizer >> updateStrong: focus [
	visualizer highlight: nil.
	visualizer selected: focus.
	visualizer refresh
]

{ #category : #notifications }
MidasAppVisualizer >> updateWeak: focus [
	visualizer highlight: focus.
	visualizer refresh
]

{ #category : #accessing }
MidasAppVisualizer >> visualizer [
	^ visualizer 
]
