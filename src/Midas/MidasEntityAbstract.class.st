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

{ #category : #accessing }
MidasEntityAbstract >> ancestors [
	self subclassResponsibility
]

{ #category : #accessing }
MidasEntityAbstract >> childrenFor: anAncestor [
	self subclassResponsibility 
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

{ #category : #testing }
MidasEntityAbstract >> hasSourceAnchor [
	^ false
]

{ #category : #testing }
MidasEntityAbstract >> isCollection [
	^ false
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
MidasEntityAbstract >> nextGenerationFromCollect: aBlock [
	"aBlock takes as argument a single entity of the receiving MidasEntity.
	 This method produces a new MidasEntity from its execution keeping track of the ancestors,
	 i.e. which old entity (current generation) resulted in which new entity (new generation)"
	^self nextGenerationFromCollection:
		(self entitiesWithAncestors flatCollect: [ :assoc |
			assoc value collect: [ :each | each -> (aBlock value: each) ]
		])

]

{ #category : #'instance creation' }
MidasEntityAbstract >> nextGenerationFromCollection: nextGeneration [
	"Creates a new generation from a collection of ancestor->{entities}
	 Keeps track of the ancestor of each entity"

	| filteredGeneration |
	"only one entity, is it a MooseModel or a 'normal' FamixEntity ?"
	filteredGeneration := nextGeneration reject: [ :nextAssoc | nextAssoc value isEmpty ].
	
	filteredGeneration
		ifEmpty: [ ^ MidasEntityEmpty ancestor: self entities ].

	( (filteredGeneration size > 1) or: [ filteredGeneration first value size > 1 ] )
		ifTrue: [ ^ self nextGenerationIsCollection: filteredGeneration ].

	^ self nextGenerationIsSingleEntity: filteredGeneration
]

{ #category : #'instance creation' }
MidasEntityAbstract >> nextGenerationFromProperty: aProperty [
	^(aProperty isMultivalued)
		ifTrue: [ self nextGenerationFromCollect: [ :entity | entity perform: aProperty methodSelector ] ]
		ifFalse: [ self nextGenerationFromCollect: [ :entity | {entity perform: aProperty methodSelector} ] ]
]

{ #category : #'instance creation' }
MidasEntityAbstract >> nextGenerationFromSelect: aBlock [
	"aBlock takes as argument a single entity of the receiving MidasEntity.
	 This method produces a new MidasEntity from its execution keeping only the entities
	 (and their ancestor) for which aBlock is true"
	^self nextGenerationFromCollection:
		(self entitiesWithAncestors collect: [ :assoc |
			assoc key -> (assoc value select: [ :each | aBlock value: each ])
		])

]

{ #category : #'instance creation' }
MidasEntityAbstract >> nextGenerationIsCollection: nextGeneration [
	"Collection of FamixEntities or of FamixAssociations?
	 Assume all are similar si just test one"
	
	^(nextGeneration first value first isAssociation)
		ifTrue:  [ MidasEntityFamixAssociation with: nextGeneration ]
		ifFalse: [ MidasEntityCollection with: nextGeneration ]
]

{ #category : #'instance creation' }
MidasEntityAbstract >> nextGenerationIsSingleEntity: filteredGeneration [
	| entity |
	entity := filteredGeneration first value first.	"only one entity, is it a MooseModel or a 'normal' FamixEntity ?"
	^ entity class = MooseModel
		ifTrue: [ MidasEntityMooseModel with: entity ]
		ifFalse:
			[ MidasEntityFamix with: entity ancestor: filteredGeneration first key ]
]

{ #category : #indexing }
MidasEntityAbstract >> pathsFor: midasEntities [
	self subclassResponsibility 
]

{ #category : #testing }
MidasEntityAbstract >> sameModel: aModel [
	^ false
]

{ #category : #indexing }
MidasEntityAbstract >> selectEntitiesFromIndexes: indexes [
	self subclassResponsibility
]

{ #category : #indexing }
MidasEntityAbstract >> selectEntitiesFromPaths: indexes [
	self subclassResponsibility
]

{ #category : #accessing }
MidasEntityAbstract >> size [
	^self entities size
]
