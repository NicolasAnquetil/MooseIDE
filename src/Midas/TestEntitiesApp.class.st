Class {
	#name : #TestEntitiesApp,
	#superclass : #TestMidasApp,
	#instVars : [
		'entitiesApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestEntitiesApp >> indexFor: aString [
	^ 	entitiesApp lstEntities items
			detectIndex: [ :item | item name beginsWith: aString ]
			 ifNone: [ 0 ].

]

{ #category : #running }
TestEntitiesApp >> listedEntities [
	^ entitiesApp lstEntities items
]

{ #category : #running }
TestEntitiesApp >> setUp [
	super setUp.
	entitiesApp := launcherApp launchEntitiesApp.
]

{ #category : #tests }
TestEntitiesApp >> testDefaultToFrozen [
	self deny: entitiesApp chkFreeze state

]

{ #category : #tests }
TestEntitiesApp >> testFilterQuery [
	|  mockCtxt query ctxtReceived|
	mockCtxt := Mock new.
	(mockCtxt 	stub interpretQuery: Any) will: [:arg | ctxtReceived := arg].
	entitiesApp context: mockCtxt.
	
	query := 'each name = ''Node'''.

	entitiesApp mnuSelcol selectedIndex: 1.	"select #filter"
	entitiesApp fldQuery text: query.
	entitiesApp btnQuery performAction.
	
	self assert: entitiesApp filterQuery.
	self assert: ctxtReceived equals: query.

]

{ #category : #tests }
TestEntitiesApp >> testSelectEntity [
	| mockCtxt userSelection |
	userSelection := nil.
	mockCtxt := Mock new.
	(mockCtxt stub userSelection: Any)
		will: [ :arg | userSelection := arg ].
	entitiesApp context: mockCtxt.

	entitiesApp updateMidasFocus: #(entity1 entity2 entity3 entity4 entity5).

	self assert: self listedEntities size equals: 5.

	entitiesApp lstEntities clickAtIndex: 3.
	self assert: userSelection size equals: 1.
	self assert: userSelection first equals: 3
]

{ #category : #tests }
TestEntitiesApp >> testSelectionFreezeOnFocusButton [
	entitiesApp chkSelectionToFocus state: true.
	self deny: entitiesApp btnFocusOnSelection isEnabled.
	entitiesApp chkSelectionToFocus state: false.
	self assert: entitiesApp btnFocusOnSelection isEnabled

]

{ #category : #tests }
TestEntitiesApp >> testSelectionFrozenDefault [
	self deny: entitiesApp chkSelectionToFocus state.
	self assert: entitiesApp context selectionFrozen

]

{ #category : #tests }
TestEntitiesApp >> testWindowTitle [
	self
		assert: entitiesApp window title
		equals: 'Query ''Model: First-lanModel'''.
	launcherApp context mooseModel: (MidasEntityMooseModel with: models second).
	self
		assert: entitiesApp window title
		equals: 'Query ''Model: Second-simpleModel'''
]
