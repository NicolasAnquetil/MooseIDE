"
pc := ProgressCircle new color: Color blue.
pc extent: 500@500.
pc percentage: 0.3.
pc position: pc topRight.
pc openInWorld.

mes := MorphEventSubscription new
	recipient: CORAEventRecipient new;
	selector: #hello.

meh := MorphicEventHandler new 
	addSubscription: mes toEvent: #click.

pc eventHandler: meh.


"
Class {
	#name : #RunButton,
	#superclass : #CircleMorph,
	#instVars : [
		'scripts',
		'current'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Midas-helpers'
}

{ #category : #example }
RunButton class >> run [
	<example>
	instance ifNotNil: [ instance delete ].
	^ (instance := self new) openInWorld.
]

{ #category : #example }
RunButton class >> script: aBlock [
	instance ifNil: [ ^ nil ].
	instance script: aBlock
]

{ #category : #accessing }
RunButton >> balloonText [
	^ self script asString
]

{ #category : #drawing }
RunButton >> handlesMouseDown: anEvent [ 
    ^ true
]

{ #category : #initialization }
RunButton >> initialize [
	super initialize. 
	current := 0.
	scripts := OrderedCollection new.
	self
		script: [ UIManager default inform: 'Set a script to run with:', String cr , self class name asString , ' script: <a-block-without-parameter>' ] ;
		extent: 75 @ 75;
		color: Color green
]

{ #category : #drawing }
RunButton >> mouseDown: anEvent [
	anEvent whichButton = 4 "left/primary button"
		ifTrue: [self script value].
     
]

{ #category : #accessing }
RunButton >> script [
	^scripts at: current
]

{ #category : #accessing }
RunButton >> script: aBlock [
	scripts add: aBlock.
	current := current+1
]
