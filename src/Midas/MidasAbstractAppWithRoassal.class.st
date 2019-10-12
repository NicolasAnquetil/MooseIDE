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
	self roassalScript.
	self flag: 'big hack to force redisplaying of menuItems now unabled. No idea why and how it works'.
	self needRebuild: false.
	self buildWithSpec
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
