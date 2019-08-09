Class {
	#name : #TestHistoryApp,
	#superclass : #TestMidasApp,
	#instVars : [
		'historyApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestHistoryApp >> colorForRoassalElement: anInteger [ 
	^ (historyApp view elements at: anInteger) trachelShape allShapes second color
]

{ #category : #running }
TestHistoryApp >> setUp [
	super setUp.
	historyApp := launcherApp launchHistoryApp
]

{ #category : #tests }
TestHistoryApp >> testBack [
	self assert: historyApp context history size equals: 1.
	historyApp context midasFocus: self someClasses.
	self assert: historyApp context history size equals: 2.
	historyApp btnPrev performAction.
	self assert: historyApp context history size equals: 2.

]

{ #category : #tests }
TestHistoryApp >> testCurrentHighlighted [
	self assert: (self colorForRoassalElement: 1) equals: Color red.
	historyApp context midasFocus: self someClasses.
	self assert: (self colorForRoassalElement: 1) equals: Color veryLightGray.
	self assert: (self colorForRoassalElement: 2) equals: Color red.
	historyApp btnPrev performAction.
	self assert: (self colorForRoassalElement: 1) equals: Color red.
	self assert: (self colorForRoassalElement: 2) equals: Color veryLightGray.

]

{ #category : #tests }
TestHistoryApp >> testEntryName [
	self assert: historyApp context currentName equals: ''.
	historyApp fldName text: 'blah'.
	historyApp btnName performAction.
	self assert: historyApp context currentName equals: 'blah'.

]

{ #category : #tests }
TestHistoryApp >> testPreviousAndNext [
	| focusBefore focusAfter |
	focusBefore := historyApp context midasFocus.
	historyApp context midasFocus: self someClasses.
	focusAfter := historyApp context midasFocus.
	self deny: focusAfter equals: focusBefore.
	historyApp btnPrev performAction.
	self assert: historyApp context midasFocus equals: focusBefore.
	historyApp btnNext performAction.
	self assert: historyApp context midasFocus equals: focusAfter
]

{ #category : #tests }
TestHistoryApp >> testPreviousAndNextButtonsStatus [
	self deny: historyApp btnPrev isEnabled.
	self deny: historyApp btnNext isEnabled.
	historyApp context midasFocus: self someClasses.
	self assert: historyApp btnPrev isEnabled.
	self deny: historyApp btnNext isEnabled.
	historyApp btnPrev performAction.
	self deny: historyApp btnPrev isEnabled.
	self assert: historyApp btnNext isEnabled.
]
