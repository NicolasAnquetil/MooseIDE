Class {
	#name : #MidasAbstractAppWithRoassal,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'view',
		'roassal'
	],
	#category : #'Midas-appGUI'
}

{ #category : #accessing }
MidasAbstractAppWithRoassal >> roassal [
	^ roassal
]

{ #category : #accessing }
MidasAbstractAppWithRoassal >> roassal: anObject [
	roassal := anObject
]

{ #category : #accessing }
MidasAbstractAppWithRoassal >> view [
	^ view
]

{ #category : #accessing }
MidasAbstractAppWithRoassal >> view: anObject [
	view := anObject
]
