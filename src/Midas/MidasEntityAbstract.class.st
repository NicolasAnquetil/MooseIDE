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
	#category : #'Midas-context'
}

{ #category : #accessing }
MidasEntityAbstract >> ancestor [
	^ancestor
]

{ #category : #accessing }
MidasEntityAbstract >> ancestor: anAncestor [
	ancestor := anAncestor
]

{ #category : #formatting }
MidasEntityAbstract >> displayString [
	self subclassResponsibility
]

{ #category : #formatting }
MidasEntityAbstract >> entities [
	self subclassResponsibility
]

{ #category : #testing }
MidasEntityAbstract >> hasSourceAnchor [
	^ false
]

{ #category : #running }
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
	self subclassResponsibility 
]

{ #category : #testing }
MidasEntityAbstract >> sameModel: aModel [
	^ false
]

{ #category : #running }
MidasEntityAbstract >> selectEntitiesIndexed: indexes [
	self subclassResponsibility
]
