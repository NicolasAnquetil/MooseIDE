Class {
	#name : #MidasRoassalDaisy,
	#superclass : #SpPresenter,
	#instVars : [
		'diagram',
		'view',
		'btns',
		'btnZoomIn',
		'btnZoomOut'
	],
	#category : #'Midas-helpers'
}

{ #category : #specs }
MidasRoassalDaisy class >> defaultSpec [ 
	<spec: #default>
	^ SpBoxLayout newVertical
			add: #btns withConstraints: [:const | const height: self buttonHeight ];
			add: #diagram
]

{ #category : #initialization }
MidasRoassalDaisy >> initializeWidgets [
	btnZoomIn := self newButton label: '+' ; action: [ RTZoomInMove on: view ].
	btnZoomOut := self newButton label: '-' ; action: [ RTZoomOutMove on: view ].
	btns := self newButtonBar.
	btns add: btnZoomIn ; add: btnZoomOut.
	diagram := self instantiate: RoassalModel.	
	diagram script: [ :aView :canvas |
		self view: aView.
	].

]

{ #category : #accessing }
MidasRoassalDaisy >> parentApp [
	^ self owner
]
