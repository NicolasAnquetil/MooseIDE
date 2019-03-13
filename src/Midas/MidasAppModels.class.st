Class {
	#name : #MidasAppModels,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'lstModels'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppModels class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newRow: [ :r | r add: #lstModels ];
		yourself
]

{ #category : #accessing }
MidasAppModels >> context: aContext [
	super context: aContext.
	lstModels items: aContext allModels
]

{ #category : #api }
MidasAppModels >> extent [
	^ 100 @ 300
]

{ #category : #initialization }
MidasAppModels >> initializePresenter [
	super initializePresenter.
	lstModels
		doubleClickAction: [ :item | self context mooseModel: lstModels selectedItem ]
]

{ #category : #initialization }
MidasAppModels >> initializeWidgets [
	super initializeWidgets.
	lstModels := (self instantiate: FastTablePresenter)
		displayBlock: [ :item | item name ];
		icons: [ :item | item mooseIcon ];
		sortingBlock: [ :a :b | a name < b name ];
		yourself.

]

{ #category : #accessing }
MidasAppModels >> lstModels [
	^ lstModels
]

{ #category : #api }
MidasAppModels >> title [
	^'Moose models'
]

{ #category : #notifications }
MidasAppModels >> updateMooseModel: newModel [
	
]

{ #category : #notifications }
MidasAppModels >> updateStrongFocus: focus [
	self shouldNotImplement 
]

{ #category : #notifications }
MidasAppModels >> updateWeakFocus: focus [
	self shouldNotImplement
]
