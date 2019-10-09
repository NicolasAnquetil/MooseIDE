Class {
	#name : #MidasAppQuery,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'mnuSelcol',
		'filterQuery',
		'fldQuery',
		'btnQuery'
	],
	#category : #'Midas-appGUI'
}

{ #category : #initialization }
MidasAppQuery >> initializeWidgetsQueryRow [
	mnuSelcol := self newDropList.
	mnuSelcol
		items: #(#filter #navigate);
		displayBlock: [ :i | i asString ].
	filterQuery := true.	"by default will be on #filter"
	fldQuery := self newTextInput.
	btnQuery := self newButton.
	btnQuery label: 'run'.
	btnQuery action: self runQueryButtonAction
]

{ #category : #running }
MidasAppQuery >> runQueryButtonAction [
	^[ context interpretQuery: fldQuery getText  ]
]
