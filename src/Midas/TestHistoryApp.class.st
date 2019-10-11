Class {
	#name : #TestHistoryApp,
	#superclass : #AbstractTestMidasApp,
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
TestHistoryApp >> testCurrentHighlighted [
	self assert: (self colorForRoassalElement: 1) equals: Color red.
	historyApp context midasFocus: (MidasEntityFamix with: #anEntity ancestor: #anAncestor).
	self assert: (self colorForRoassalElement: 1) equals: Color veryLightGray.
	self assert: (self colorForRoassalElement: 2) equals: Color red.
	historyApp btnPrev performAction.
	self assert: (self colorForRoassalElement: 1) equals: Color red.
	self assert: (self colorForRoassalElement: 2) equals: Color veryLightGray.

]

{ #category : #tests }
TestHistoryApp >> testEntryName [
	|  mockCtxt ctxtReceived|
	mockCtxt := Mock new.
	(mockCtxt stub currentName: Any) will: [:arg | ctxtReceived := arg].
	mockCtxt stub historyHasPrevious willReturn: false.
	mockCtxt stub historyHasNext willReturn: false.
	historyApp context: mockCtxt.

	historyApp fldName text: 'blah'.
	historyApp btnName performAction.

	self assert: ctxtReceived equals: 'blah'.
	self assert: historyApp fldName text equals: ''.


]

{ #category : #tests }
TestHistoryApp >> testEntryPopup [
	self assert: (self colorForRoassalElement: 1) equals: Color red.
	historyApp context midasFocus: (MidasEntityFamix with: #anEntity ancestor: #anAncestor).
	self assert: (self colorForRoassalElement: 1) equals: Color veryLightGray.
	self assert: (self colorForRoassalElement: 2) equals: Color red.

]

{ #category : #tests }
TestHistoryApp >> testPreviousAndNextButtonsStatus [
	self deny: historyApp btnPrev isEnabled.
	self deny: historyApp btnNext isEnabled.
	historyApp context midasFocus: (MidasEntityFamix with: #anEntity ancestor: #anAncestor).
	self assert: historyApp btnPrev isEnabled.
	self deny: historyApp btnNext isEnabled.
	historyApp btnPrev performAction.
	self deny: historyApp btnPrev isEnabled.
	self assert: historyApp btnNext isEnabled.
]
