"
I represent a Famix entity (or list of entities) inside Midas.
I also handle the notion of an ancestor, which is the MidasEntity from which this entity was derived through some query

I unify treatment for all possibilities (mooseModel, famix entity, collection of entities)

Main selectors
- displayString, how to represent the inner entity (or list of)
- entities, the list of entities contained (possibly only one)
"
Class {
	#name : #MidasEntityAbstract,
	#superclass : #Object,
	#instVars : [
		'ancestor'
	],
	#category : #'Midas-focusModel'
}

{ #category : #accessing }
MidasEntityAbstract >> ancestor [
	^ancestor
]

{ #category : #accessing }
MidasEntityAbstract >> ancestor: anAncestor [
	ancestor := anAncestor
]

{ #category : #'instance creation' }
MidasEntityAbstract >> collectNextGeneration: aBlock [
	"aBlock takes as argument a single entity of the receiving MidasEntity.
	 This method produces a new MidasEntity from its execution keeping track of the ancestors,
	 i.e. which old entity (current generation) resulted in which new entity (new generation)"
	^self filterNextGeneration:
		(self entitiesWithAncestors flatCollect: [ :assoc |
			assoc value collect: [ :each | each -> (aBlock value: each) ]
		])

]

{ #category : #formatting }
MidasEntityAbstract >> displayString [
	self subclassResponsibility
]

{ #category : #accessing }
MidasEntityAbstract >> entities [
	self subclassResponsibility
]

{ #category : #accessing }
MidasEntityAbstract >> entitiesWithAncestors [
	self subclassResponsibility
]

{ #category : #private }
MidasEntityAbstract >> filterNextGeneration: nextGeneration [
	| filteredGeneration |
	filteredGeneration := nextGeneration reject: [ :nextAssoc | nextAssoc value isEmpty ].

	filteredGeneration ifEmpty: [ ^ MidasEntityEmpty ancestor: self entities ].
	((filteredGeneration size = 1) and: [ filteredGeneration first value size = 1 ])
		ifTrue: [ ^ MidasEntityFamix
							with: filteredGeneration first value first
							ancestor: filteredGeneration first key
					].

	^ MidasEntityFamixCollection with: filteredGeneration
]

{ #category : #testing }
MidasEntityAbstract >> hasSourceAnchor [
	^ false
]

{ #category : #private }
MidasEntityAbstract >> indexInListWithoutAncestors: index [
	self subclassResponsibility
]

{ #category : #running }
MidasEntityAbstract >> indexesInListWithoutAncestors: indexes [
	"Indexes consider a list including ancestors, we translate them to indexes in the list of entities"
	^ indexes collect: [ :i | self indexInListWithoutAncestors: i ]
]

{ #category : #testing }
MidasEntityAbstract >> isEmpty [
	^ false
]

{ #category : #testing }
MidasEntityAbstract >> isModel [
	^ false
]

{ #category : #'instance creation' }
MidasEntityAbstract >> nextGenerationSelector: aSelector [
	^self collectNextGeneration: [ :entity | entity perform: aSelector ]
]

{ #category : #testing }
MidasEntityAbstract >> sameModel: aModel [
	^ false
]

{ #category : #'instance creation' }
MidasEntityAbstract >> selectEntitiesIndexed: indexes [
	self subclassResponsibility
]

{ #category : #'instance creation' }
MidasEntityAbstract >> selectNextGeneration: aBlock [
	"aBlock takes as argument a single entity of the receiving MidasEntity.
	 This method produces a new MidasEntity from its execution keeping only the entities
	 (and their ancestor) for which aBlock is true"
	^self filterNextGeneration:
		(self entitiesWithAncestors collect: [ :assoc |
			assoc key -> (assoc value select: [ :each | aBlock value: each ])
		])

]

{ #category : #accessing }
MidasEntityAbstract >> size [
	^self entities size
]
