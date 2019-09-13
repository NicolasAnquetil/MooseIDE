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
	| displayUpdated |
	(mockApp stub updateMidasFocus: Any) will: [ displayUpdated := true].

	launcherCtxt midasFocus: self someNamespaces.
	entitiesCtxt freeze.
	displayUpdated := false.
	launcherCtxt midasFocus: self someClasses.
	self deny: displayUpdated 
]

{ #category : #tests }
TestCtxtEntities >> testNotFrozen [
	| displayUpdated |
	(mockApp stub updateMidasFocus: Any) will: [ displayUpdated := true].

	launcherCtxt midasFocus: self someNamespaces.
	entitiesCtxt unfreeze.
	displayUpdated := false.
	launcherCtxt midasFocus: self someClasses.
	self assert: displayUpdated 
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

{ #category : #tests }
TestCtxtEntities >> testSelectionFrozen [
	| displayUpdated midasEntities |
	(mockApp stub updateMidasFocus: Any) will: [ displayUpdated := true].

	launcherCtxt midasFocus: self someNamespaces.
	entitiesCtxt selectionNoFocus.
	displayUpdated := false.

	midasEntities := self someClasses collect: [:c | MidasEntityTransparent with: c].
	entitiesCtxt userSelection: midasEntities.
	self deny: displayUpdated.

	entitiesCtxt focusOnSelection: midasEntities.
	self assert: displayUpdated.

]

{ #category : #tests }
TestCtxtEntities >> testSelectionNotFrozen [
	| displayUpdated |
	(mockApp stub updateMidasFocus: Any) will: [ displayUpdated := true].

	launcherCtxt midasFocus: self someNamespaces.
	entitiesCtxt selectionToFocus.
	displayUpdated := false.
	entitiesCtxt userSelection: (self someClasses collect: [:c | MidasEntityTransparent with: c]).
.
	self assert: displayUpdated 
]
