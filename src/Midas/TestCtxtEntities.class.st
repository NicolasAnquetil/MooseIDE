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
	entitiesCtxt midasFocus: self someNamespaces.
	entitiesCtxt freeze.
	entitiesCtxt userSelection: self someClasses.
	self assert: entitiesCtxt midasFocus equals: self someNamespaces
]

{ #category : #tests }
TestCtxtEntities >> testNotFrozen [
	entitiesCtxt midasFocus: self someNamespaces.
	entitiesCtxt unfreeze.
	entitiesCtxt userSelection: self someClasses.
	self assert: entitiesCtxt midasFocus equals: self someClasses
]

{ #category : #tests }
TestCtxtEntities >> testScopeClasses [
	entitiesCtxt midasFocus: self somePackages.
	entitiesCtxt classScope.
	self assert: entitiesCtxt midasFocus size equals: 6.
	entitiesCtxt midasFocus do: [ :each | self assert: each isClass ]
]

{ #category : #tests }
TestCtxtEntities >> testScopeMethods [
	entitiesCtxt midasFocus: self someClasses.
	entitiesCtxt methodScope.
	self assert: entitiesCtxt midasFocus size equals: 58.
	entitiesCtxt midasFocus do: [ :each | self assert: each isMethod ]

]

{ #category : #tests }
TestCtxtEntities >> testScopePackage [
	entitiesCtxt midasFocus: self someClasses.
	entitiesCtxt packageScope.
	self assert: entitiesCtxt midasFocus size equals: 1.
	self assert: entitiesCtxt midasFocus first name equals: 'LANSimulation'

]
