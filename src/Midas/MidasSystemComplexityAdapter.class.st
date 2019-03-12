Class {
	#name : #MidasSystemComplexityAdapter,
	#superclass : #MVSSystemComplexityPresenter,
	#instVars : [
		'midas'
	],
	#category : #'Midas-apps'
}

{ #category : #drawing }
MidasSystemComplexityAdapter >> drawOnRoassalView: aView [
	super drawOnRoassalView: aView.
	aView elements removeInteractionIfPresent: RTMVSElInteraction.
	aView elements
		do: [ :el | 
			el announcer
				when: TRMouseClick
				do: [ 	midas context weakFocus: el model ] ]
]

{ #category : #acccessing }
MidasSystemComplexityAdapter >> parentApp: aQueryApp [
	midas := aQueryApp
]
