Class {
	#name : #TestEntitiesApp,
	#superclass : #AbstractTestMidasApp,
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
TestEntitiesApp >> listedEntitiesFlat [
	^ entitiesApp lstEntities roots 
]

{ #category : #running }
TestEntitiesApp >> listedEntitiesTree [
	| presenter |
	presenter := entitiesApp lstEntities.
	^ presenter roots flatCollect: [ :r | presenter childrenFor: r ]
]

{ #category : #running }
TestEntitiesApp >> setUp [
	super setUp.
	entitiesApp := launcherApp launchEntitiesApp.
]

{ #category : #tests }
TestEntitiesApp >> testBtnBypassFreeze [
	entitiesApp context unfreeze.
	self deny: entitiesApp btnBypassFreeze isEnabled.

	entitiesApp context freeze.
	self assert: entitiesApp btnBypassFreeze isEnabled.
]

{ #category : #tests }
TestEntitiesApp >> testChangeModel [
	launcherApp context mooseModel: (MidasEntityMooseModel with: models first).

	self assert: self listedEntitiesFlat size equals: 1.

]

{ #category : #tests }
TestEntitiesApp >> testClearSelection [
	| mockCtxt |
	mockCtxt := Mock new.
	(mockCtxt stub childrenFor: Any)
		willReturn: #().
	entitiesApp context: mockCtxt.

	entitiesApp displayFocus:
						{ self mockEntity: #entity1 .
						  self mockEntity: #entity2 }.

	entitiesApp lstEntities clickAtPath: #(1).
	self assert: entitiesApp selectedPaths size equals: 1.

	entitiesApp displayFocus:
						{ self mockEntity: #entity1 .
						  self mockEntity: #entity2 }.

	self assert: entitiesApp selectedPaths size equals: 0
]

{ #category : #tests }
TestEntitiesApp >> testDefaultToFrozen [
	self deny: entitiesApp chkFreeze state

]

{ #category : #tests }
TestEntitiesApp >> testSelectEntity [
	| mockCtxt userSelection |
	userSelection := nil.
	mockCtxt := Mock new.
	(mockCtxt stub userSelection: Any)
		will: [ :arg | userSelection := arg ].
	(mockCtxt stub childrenFor: Any)
		willReturn: #().
	entitiesApp context: mockCtxt.

	entitiesApp displayFocus:
						{ self mockEntity: #entity1 .
						  self mockEntity: #entity2 .
						  self mockEntity: #entity3 .
						  self mockEntity: #entity4 .
						  self mockEntity: #entity5 }.

	self assert: self listedEntitiesFlat size equals: 5.

	entitiesApp lstEntities clickAtPath: #(3).
	self assert: userSelection size equals: 1.
	self assert: userSelection first equals: #(3)
]

{ #category : #tests }
TestEntitiesApp >> testWindowTitle [
	self
		assert: entitiesApp window title
		equals: 'Entities ''Model: First-lanModel'''.
	launcherApp context mooseModel: (MidasEntityMooseModel with: models second).
	self
		assert: entitiesApp window title
		equals: 'Entities ''Model: Second-simpleModel'''
]
