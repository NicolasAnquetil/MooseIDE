Class {
	#name : #MidasAbstractAppWithRoassal,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'view',
		'roassal'
	],
	#category : #'Midas-appGUI'
}

{ #category : #initialization }
MidasAbstractAppWithRoassal >> initialize [
	super initialize.
	self refresh
]

{ #category : #refreshing }
MidasAbstractAppWithRoassal >> refresh [
	view := RTView new.
	roassal := SpMorphPresenter new
					morph: view canvas buildMorph;
					yourself.
	self roassalScript 
]

{ #category : #accessing }
MidasAbstractAppWithRoassal >> roassal [
	^ roassal
]

{ #category : #accessing }
MidasAbstractAppWithRoassal >> roassal: anObject [
	roassal := anObject
]

{ #category : #refreshing }
MidasAbstractAppWithRoassal >> roassalScript [
	self subclassResponsibility 
]

{ #category : #accessing }
MidasAbstractAppWithRoassal >> view [
	^ view
]

{ #category : #accessing }
MidasAbstractAppWithRoassal >> view: anObject [
	view := anObject
]
