Class {
	#name : #TestCtxtEntities,
	#superclass : #TestMidasCtxt,
	#instVars : [
		'entitiesCtxt'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestCtxtEntities >> setUp [
	super setUp.
	entitiesCtxt := launcherCtxt spawn: MidasContextEntities.
	entitiesCtxt app: self mockEmptyApp.
]

{ #category : #tests }
TestCtxtEntities >> testFilterQuery [
	mockApp stub filterQuery willReturn: true.

	entitiesCtxt interpretQuery: 'each name = ''Node'''.

	self assert: entitiesCtxt midasFocus size equals: 1.
	self assert: entitiesCtxt midasFocus first name equals: 'Node'	
]

{ #category : #tests }
TestCtxtEntities >> testFrozen [
	entitiesApp context midasFocus: self someNamespaces.
	entitiesApp chkFreeze state: false.
	entitiesApp context midasFocus: self someClasses.
	self assert: self listedEntities asOrderedCollection equals: self someClasses asOrderedCollection 
]

{ #category : #tests }
TestCtxtEntities >> testNotFrozen [
	entitiesApp context midasFocus: self someNamespaces.
	entitiesApp chkFreeze state: false.
	entitiesApp context midasFocus: self someClasses.
	self assert: self listedEntities asOrderedCollection equals: self someClasses asOrderedCollection
]

{ #category : #tests }
TestCtxtEntities >> testScopeClasses [
	entitiesApp context midasFocus: self somePackages.
	entitiesApp btnClassScope performMenuActionWith: self.
	self assert: self listedEntities size equals: 6.
	self listedEntities do: [ :each | self assert: each isClass ]
]

{ #category : #tests }
TestCtxtEntities >> testScopeMethods [
	entitiesApp context midasFocus: self someClasses.
	entitiesApp btnMethodScope performMenuActionWith: self.
	self assert: self listedEntities size equals: 58.
	self listedEntities do:[:each|self assert: each isMethod]
]

{ #category : #tests }
TestCtxtEntities >> testScopePackage [
	entitiesApp context midasFocus: self someClasses.
	entitiesApp btnPackageScope performMenuActionWith: self.
	self assert: self listedEntities size equals: 1.
	self assert: self listedEntities first name equals: 'LANSimulation'
]
