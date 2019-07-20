Class {
	#name : #TestHistoryApp,
	#superclass : #TestMidasApp,
	#instVars : [
		'historyApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestHistoryApp >> testPreviousAndNext [
	| cachedModelContent cachedAllClasses |
	cachedModelContent := historyApp context strongFocus.
	historyApp context strongFocus: self someClasses.
	cachedAllClasses := historyApp context strongFocus.
	self deny: cachedAllClasses equals: cachedModelContent.
	historyApp btnPrev performAction.
	self assert: historyApp context strongFocus equals: cachedModelContent.
	historyApp btnNext performAction.
	self assert: historyApp context strongFocus equals: cachedAllClasses
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
