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
	^ entitiesApp lstEntities items collect: #selection
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
	self assert: self listedEntities size equals: 1.
	self assert: self listedEntities first name equals: 'Node'	
]

{ #category : #tests }
TestEntitiesApp >> testFrozen [
	entitiesApp context midasFocus: self someNamespaces.
	entitiesApp chkFreeze state: false.
	entitiesApp context midasFocus: self someClasses.
	self assert: self listedEntities asOrderedCollection equals: self someClasses asOrderedCollection 
]

{ #category : #tests }
TestEntitiesApp >> testNotFrozen [
	entitiesApp context midasFocus: self someNamespaces.
	entitiesApp chkFreeze state: false.
	entitiesApp context midasFocus: self someClasses.
	self assert: self listedEntities asOrderedCollection equals: self someClasses asOrderedCollection
]

{ #category : #tests }
TestEntitiesApp >> testScopeClasses [
	entitiesApp context midasFocus: self somePackages.
	entitiesApp btnClassScope performMenuActionWith: self.
	self assert: self listedEntities size equals: 6.
	self listedEntities do: [ :each | self assert: each isClass ]
]

{ #category : #tests }
TestEntitiesApp >> testScopeMethods [
	entitiesApp context midasFocus: self someClasses.
	entitiesApp btnMethodScope performMenuActionWith: self.
	self assert: self listedEntities size equals: 58.
	self listedEntities do:[:each|self assert: each isMethod]
]

{ #category : #tests }
TestEntitiesApp >> testScopePackage [
	entitiesApp context midasFocus: self someClasses.
	entitiesApp btnPackageScope performMenuActionWith: self.
	self assert: self listedEntities size equals: 1.
	self assert: self listedEntities first name equals: 'LANSimulation'
]

{ #category : #tests }
TestEntitiesApp >> testWindowTitle [
	self
		assert: entitiesApp window title
		equals: 'MIDAS Query: ''First-lanModel'''.
	launcherApp context mooseModel: models second.
	self
		assert: entitiesApp window title
		equals: 'MIDAS Query: ''Second-simpleModel'''
]
