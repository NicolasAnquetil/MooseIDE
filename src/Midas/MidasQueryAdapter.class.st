"
An adapter between Honore's query window and Midas infrastructure
"
Class {
	#name : #MidasQueryAdapter,
	#superclass : #MMCMainPresenter,
	#instVars : [
		'midas'
	],
	#category : #'Midas-apps'
}

{ #category : #initialization }
MidasQueryAdapter >> initializeContext [

]

{ #category : #acccessing }
MidasQueryAdapter >> parentApp: aQueryApp [
	midas := aQueryApp  
]

{ #category : #updating }
MidasQueryAdapter >> update [
	mooseModelPresenter update.
	mooseFormPresenter update
]

{ #category : #notifications }
MidasQueryAdapter >> updateWeakFocus: newFocus [
	mooseModelPresenter setSelectionTo: newFocus
]
