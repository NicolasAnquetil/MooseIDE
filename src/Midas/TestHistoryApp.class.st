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
	cachedModelContent := entitiesApp lstEntities items
		collect: [ :item | item selection ].
	entitiesApp lstEntities doubleClickAtIndex: 1.   "All model classes"
	cachedAllClasses := entitiesApp lstEntities items
		collect: [ :item | item selection ].
	self deny: cachedAllClasses equals: cachedModelContent.
	entitiesApp btnPrev performAction.
	self assert: (entitiesApp lstEntities items 	collect: [ :item | item selection ])equals: cachedModelContent.
	entitiesApp btnNext performAction.
	self assert: (entitiesApp lstEntities items 	collect: [ :item | item selection ])equals: cachedAllClasses
]

{ #category : #tests }
TestHistoryApp >> testPreviousAndNextButtonsStatus [
	self deny: entitiesApp btnPrev isEnabled.
	self deny: entitiesApp btnNext isEnabled.
	entitiesApp lstEntities doubleClickAtIndex: 1.   "All model classes"
	self assert: entitiesApp btnPrev isEnabled.
	self deny: entitiesApp btnNext isEnabled.
	entitiesApp btnPrev performAction.
	self deny: entitiesApp btnPrev isEnabled.
	self assert: entitiesApp btnNext isEnabled.
]
