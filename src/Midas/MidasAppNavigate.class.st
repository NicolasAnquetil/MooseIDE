Class {
	#name : #MidasAppNavigate,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'notebook'
	],
	#category : #'Midas-appGUI'
}

{ #category : #'as yet unclassified' }
MidasAppNavigate >> entitiesPage [
		
]

{ #category : #initialization }
MidasAppNavigate >> initializeWidgets [
	self canBeFrozen.
	self focusCanBeHierarchical.

	notebook := self newNotebook.

	notebook
		addPage: self entitiesPage ;
		addPage: self queryPage
]

{ #category : #'as yet unclassified' }
MidasAppNavigate >> queryPage [
		
]
