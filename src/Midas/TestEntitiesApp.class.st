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
TestEntitiesApp >> testScopeClasses [
	entitiesApp context strongFocus: (models first allModelPackages).
	entitiesApp btnClassScope performMenuActionWith: self.
	self assert: entitiesApp lstEntities items size equals: 6.
	entitiesApp lstEntities items
		do: [ :each | self assert: each selection isClass ]
]

{ #category : #tests }
TestEntitiesApp >> testScopeMethods [
	entitiesApp context strongFocus: (models first allModelClasses).
	entitiesApp btnMethodScope performMenuActionWith: self.
	self assert: entitiesApp lstEntities items size equals: 58.
	entitiesApp lstEntities items do:[:each|self assert: each selection isMethod]
]

{ #category : #tests }
TestEntitiesApp >> testScopePackage [
	entitiesApp context strongFocus: (models first allModelClasses).
	entitiesApp btnPackageScope performMenuActionWith: self.
	self assert: entitiesApp lstEntities items size equals: 1.
	self assert: entitiesApp lstEntities items first selection name equals: 'LANSimulation'
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
