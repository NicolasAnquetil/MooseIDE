"
An app showing a visualization on the current model or selected entity-ies
"
Class {
	#name : #MidasAppSystemComplexity,
	#superclass : #MidasAbstractAppWithRoassal,
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasAppSystemComplexity class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
				add: #chkFreeze;
				add: #btnFocusOnSelection ;
				add: #chkHierarchicalFocus ;
				yourself)
		withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #roassal ;
		yourself
]

{ #category : #initialization }
MidasAppSystemComplexity >> drawEntities [
	| es |
	view @ RTZoomableView.
	view @ RTDraggableView.
	es := (RTBox new
		borderColor: Color black;
		width: 10 ;
		height: 10 ;
		color: Color black) elementsOn: self context entities.
	view addAll: es.
	es @ RTPopup.
	es @ RTMVSElInteraction.
	es @ RTDraggable.
"	RTEdgeBuilder new
		elements: es;
		view: view;
		connectToAll: [ :cls | cls directSubclasses ].
	RTTreeLayout new on: es.
	RTMetricNormalizer new
		elements: es;
		normalizeColorAsGray: [ :cls | cls numberOfLinesOfCode ]."
	RTGridLayout new
		on: es.
]

{ #category : #initialization }
MidasAppSystemComplexity >> initializeWidgets [
	self canBeFrozen.
	self focusCanBeHierarchical.

	roassal := self instantiate: RoassalModel.
	roassal
		script: [ :aView :canvas | 
			view := aView.
			self drawEntities ]
]

{ #category : #api }
MidasAppSystemComplexity >> title [
	^ 'MIDAS Visualizer' 
]

{ #category : #notifications }
MidasAppSystemComplexity >> updateMidasFocus: newFocus [
	roassal ifNotNil: [ roassal refresh ]
]
