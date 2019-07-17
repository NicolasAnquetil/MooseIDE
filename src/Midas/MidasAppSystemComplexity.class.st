"
An app showing a visualization on the current model or selected entity-ies
"
Class {
	#name : #MidasAppSystemComplexity,
	#superclass : #MidasAbstractAppWithRoassal,
	#instVars : [
		'visualizer'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppSystemComplexity class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #chkFreeze withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #visualizer;
		yourself
]

{ #category : #private }
MidasAppSystemComplexity >> delete [
	visualizer delete.
	visualizer := nil.
	super delete
]

{ #category : #initialization }
MidasAppSystemComplexity >> initializeWidgets [
	super initializeWidgets.
	visualizer := self instantiate: MidasSystemComplexityAdapter	"MVSSystemComplexityPresenter".
	visualizer parentApp: self
]

{ #category : #api }
MidasAppSystemComplexity >> title [
	^ 'MIDAS Visualizer' 
]

{ #category : #notifications }
MidasAppSystemComplexity >> updateModel: aMooseModel [
	self shouldNotImplement
]

{ #category : #notifications }
MidasAppSystemComplexity >> updateStrongFocus: newFocus [
	visualizer highlight: nil.
	visualizer selected: newFocus.
	visualizer refresh
]

{ #category : #notifications }
MidasAppSystemComplexity >> updateWeakFocus: newFocus [
	visualizer highlight: newFocus.
	visualizer refresh
]

{ #category : #accessing }
MidasAppSystemComplexity >> visualizer [
^visualizer
]
