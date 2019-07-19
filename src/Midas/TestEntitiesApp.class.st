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
TestEntitiesApp >> setUp [
	super setUp.
	entitiesApp := launcherApp launchEntitiesApp
]

{ #category : #tests }
TestEntitiesApp >> testFilterQuery [
	entitiesApp mnuSelcol selectedIndex: 1.	"select #filter"
	entitiesApp fldQuery text: 'each name = ''Node'''.
	entitiesApp btnQuery performAction.
	self assert: entitiesApp lstEntities items size equals: 1.
	entitiesApp lstEntities items first selection name = 'Node'. "use '=' because name is a ByteString, not a String ?!?!"
]

{ #category : #tests }
TestEntitiesApp >> testFreezeContentIsNotSelected [
	| cachedItems |
	cachedItems := entitiesApp lstEntities items.
	entitiesApp chkFreeze state: false.
	entitiesApp context mooseModel: models second.
	self deny: entitiesApp lstEntities items equals: cachedItems
]

{ #category : #tests }
TestEntitiesApp >> testFreezeContentIsSelected [
	| cachedItems |
	cachedItems := entitiesApp lstEntities items.
	entitiesApp chkFreeze state: true.
	entitiesApp context mooseModel: models second.
	self assert: entitiesApp lstEntities items equals: cachedItems
]

{ #category : #tests }
TestEntitiesApp >> testPreviousAndNextButtons [
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
TestEntitiesApp >> testPreviousAndNextButtonsDisplay [
	self deny: entitiesApp btnPrev isEnabled.
	self deny: entitiesApp btnNext isEnabled.
	entitiesApp lstEntities doubleClickAtIndex: 1.   "All model classes"
	self assert: entitiesApp btnPrev isEnabled.
	self deny: entitiesApp btnNext isEnabled.
	entitiesApp btnPrev performAction.
	self deny: entitiesApp btnPrev isEnabled.
	self assert: entitiesApp btnNext isEnabled.
]

{ #category : #tests }
TestEntitiesApp >> testSelectClasses [
	entitiesApp lstEntities doubleClickAtIndex: (self indexFor: 'All model packages').
	entitiesApp btnClassScope performMenuActionWith: self.
	self assert: entitiesApp lstEntities items size equals: 6.
	entitiesApp lstEntities items
		do: [ :each | self assert: each selection isClass ]
]

{ #category : #tests }
TestEntitiesApp >> testSelectMethods [
	entitiesApp lstEntities doubleClickAtIndex: (self indexFor: 'All model classes').
	entitiesApp btnMethodScope performMenuActionWith: self.
	self assert: entitiesApp lstEntities items size equals: 58.
	entitiesApp lstEntities items do:[:each|self assert: each selection isMethod]
]

{ #category : #tests }
TestEntitiesApp >> testSelectPackage [
	entitiesApp lstEntities doubleClickAtIndex: (self indexFor: 'All model classes').
	entitiesApp btnPackageScope performMenuActionWith: self.
	self assert: entitiesApp lstEntities items size equals: 1.
	self assert: entitiesApp lstEntities items first selection name equals: 'LANSimulation'
]

{ #category : #tests }
TestEntitiesApp >> testUpdateStrongFocuslWhenTheItemIsDoubleClicked [
	| item |
	item := entitiesApp lstEntities items first selection.
	self deny: entitiesApp strongFocus equals: item.
	entitiesApp lstEntities doubleClickAtIndex: 1.
	self assert: entitiesApp strongFocus equals: item
]

{ #category : #tests }
TestEntitiesApp >> testUpdateWeakFocuslWhenTheItemIsSingleClicked [
	| item |
	item := entitiesApp lstEntities items first selection.
	self deny: entitiesApp weakFocus equals: item.
	entitiesApp lstEntities clickAtIndex: 1.
	self assert: entitiesApp weakFocus equals: item
]

{ #category : #tests }
TestEntitiesApp >> testWindowTitle [
	self
		assert: entitiesApp window title
		equals: 'MIDAS Query: First-lanModel'.
	launcherApp context mooseModel: models second.
	self
		assert: entitiesApp window title
		equals: 'MIDAS Query: Second-simpleModel'
]
