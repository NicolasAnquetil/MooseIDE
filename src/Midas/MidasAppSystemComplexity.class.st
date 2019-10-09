"
An app showing a visualization on the current model or selected entity-ies
"
Class {
	#name : #MidasAppSystemComplexity,
	#superclass : #MidasAbstractAppWithRoassal,
	#instVars : [
		'highlighted'
	],
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

{ #category : #private }
MidasAppSystemComplexity >> boxShape [
	^ RTBox new
		borderColor: [ :entity | 
			(highlighted includes: entity)
				ifTrue: [ Color red ]
				ifFalse: [ Color black ] ]
]

{ #category : #initialization }
MidasAppSystemComplexity >> drawEntities [
	| viewElts shape |
	view @ RTDraggableView.
	view @ RTZoomableView.
	shape := self boxShape.
	viewElts := shape elementsOn: self context roots.
	view addAll: viewElts.
	RTNest new
		view: view ;
		for: viewElts add: [ :group :model | 
			group
				addAll: (self boxShape elementsOn: (self context childrenFor: model)).
			self setInteractions: group.
			RTGridLayout on: group
		].
	self setInteractions: viewElts.
	"	RTEdgeBuilder new
		elements: es;
		view: view;
		connectToAll: [ :cls | cls directSubclasses ].
	RTTreeLayout new on: es.
	RTMetricNormalizer new
		elements: es;
		normalizeColorAsGray: [ :cls | cls numberOfLinesOfCode ]."
	RTGridLayout new on: viewElts
]

{ #category : #api }
MidasAppSystemComplexity >> highlight: aCollection [
	highlighted := aCollection.
	self refresh
]

{ #category : #initialization }
MidasAppSystemComplexity >> initialize [
	super initialize.
	highlighted := #()
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
MidasAppSystemComplexity >> refresh [
	roassal ifNotNil: [ roassal refresh ]
]

{ #category : #accessing }
MidasAppSystemComplexity >> roassalView [
	^view
]

{ #category : #initialization }
MidasAppSystemComplexity >> setInteractions: viewElts [
	viewElts @ RTPopup.
	viewElts @ RTDraggable.
	viewElts
		when: TRMouseClick
		do: [ :event | context userSelection: event element model ].
]

{ #category : #api }
MidasAppSystemComplexity >> title [
	^ 'MIDAS Visualizer' 
]

{ #category : #notifications }
MidasAppSystemComplexity >> updateMidasFocus: newFocus [
	highlighted := #().
	self refresh
]
