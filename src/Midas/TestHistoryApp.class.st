Class {
	#name : #TestHistoryApp,
	#superclass : #TestMidasApp,
	#instVars : [
		'historyApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestHistoryApp >> setUp [
	super setUp.
	historyApp := launcherApp launchHistoryApp
]

{ #category : #tests }
TestHistoryApp >> testBack [
	self assert: historyApp context history size equals: 1.
	historyApp context strongFocus: self someClasses.
	self assert: historyApp context history size equals: 2.
	historyApp btnPrev performAction.
	self assert: historyApp context history size equals: 2.

]

{ #category : #tests }
TestHistoryApp >> testCurrentHighlighted [
	self assert: historyApp view elements first color equals: Color red.
	historyApp context strongFocus: self someClasses.
	self assert: historyApp view elements first color equals: Color veryLightGray.
	self assert: historyApp view elements second color equals: Color red.
	historyApp btnPrev performAction.
	self assert: historyApp view elements first color equals: Color red.
	self assert: historyApp view elements second color equals: Color veryLightGray.

]

{ #category : #tests }
TestHistoryApp >> testPreviousAndNext [
	| focusBefore focusAfter |
	focusBefore := historyApp context strongFocus.
	historyApp context strongFocus: self someClasses.
	focusAfter := historyApp context strongFocus.
	self deny: focusAfter equals: focusBefore.
	historyApp btnPrev performAction.
	self assert: historyApp context strongFocus equals: focusBefore.
	historyApp btnNext performAction.
	self assert: historyApp context strongFocus equals: focusAfter
]

{ #category : #tests }
TestHistoryApp >> testPreviousAndNextButtonsStatus [
	self deny: historyApp btnPrev isEnabled.
	self deny: historyApp btnNext isEnabled.
	historyApp context strongFocus: self someClasses.
	self assert: historyApp btnPrev isEnabled.
	self deny: historyApp btnNext isEnabled.
	historyApp btnPrev performAction.
	self deny: historyApp btnPrev isEnabled.
	self assert: historyApp btnNext isEnabled.
]
