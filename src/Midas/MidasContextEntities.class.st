"
Context for EntitiesApp
"
Class {
	#name : #MidasContextEntities,
	#superclass : #MidasChildContext,
	#instVars : [
		'resultsWithParents',
		'listEntities',
		'history',
		'selectionFrozen'
	],
	#category : #'Midas-appModel'
}

{ #category : #running }
MidasContextEntities >> atScope: aSymbol [
	^self midasFocus collectNextGeneration:
		(MVSFilterManager new buildQueryBlockFrom: 'each atScope: ' , aSymbol)
	
]

{ #category : #running }
MidasContextEntities >> classScope [
	| actuel |
	actuel := self midasFocus.
	actuel isEmpty ifTrue: [ ^ nil ].
	"hack to know whether we should go up (from methods -> atScope) or down (-> toScope)"
	actuel entities anyOne isMethod
		ifTrue: [ self midasFocus: (self atScope: 'FAMIXClass') ]
		ifFalse: [ self midasFocus: (self toScope: 'FAMIXClass') ].
]

{ #category : #running }
MidasContextEntities >> computeNewFocus: indexes [
	| realIndexes |
	indexes ifEmpty: [ ^ self ].
	realIndexes := resultsWithParents
							ifTrue: [ self midasFocus indexesInListWithoutAncestors: indexes ]
							ifFalse: [ indexes ].
	^ self midasFocus selectEntitiesIndexed: realIndexes
]

{ #category : #accessing }
MidasContextEntities >> flattenResult [
	resultsWithParents := false.
	self notifyMidasFocus: self midasFocus
]

{ #category : #running }
MidasContextEntities >> focusOnSelection: selectedIndexes [
	"forces receiver focus on the selection, whatever the states of the flags frozen and selectionFrozen"
	| wasFrozen |
	wasFrozen := frozen.
	frozen := false.
	self updateMidasFocus: self midasFocus.
	frozen := wasFrozen.
]

{ #category : #notifications }
MidasContextEntities >> formatMidasFocus: newFocus [
	^resultsWithParents
		ifFalse: [ newFocus entities ]
		ifTrue:  [
			newFocus isCollection
				ifTrue: [ newFocus entitiesWithAncestors ]
				ifFalse: [ newFocus entities ]
			
		]
		
]

{ #category : #notifications }
MidasContextEntities >> formatNewModel: newModel [
	^ self mooseModel allModelClasses
]

{ #category : #notifications }
MidasContextEntities >> formatedMidasFocus [
	^ self formatMidasFocus: self midasFocus
]

{ #category : #initialization }
MidasContextEntities >> initialize [
	super initialize.
	resultsWithParents := false.
	selectionFrozen := true
]

{ #category : #running }
MidasContextEntities >> interpretQuery: aBlockAsString [
	| aBlock |
	aBlockAsString
		ifEmpty: [ ^ self "notifyMidasFocus: history now" ].
	aBlock := MVSFilterManager new buildQueryBlockFrom: aBlockAsString.
	self
		midasFocus:
			(app filterQuery
				ifTrue: [ self midasFocus selectNextGeneration: aBlock ]
				ifFalse: [ self midasFocus collectNextGeneration: aBlock ])
]

{ #category : #running }
MidasContextEntities >> methodScope [
	self midasFocus: (self toScope: 'FAMIXMethod')
]

{ #category : #running }
MidasContextEntities >> packageScope [
	self midasFocus: (self atScope: 'FAMIXPackage')
]

{ #category : #accessing }
MidasContextEntities >> resultsWithParents [
	^resultsWithParents
]

{ #category : #accessing }
MidasContextEntities >> selectionFrozen [
	^ selectionFrozen
]

{ #category : #accessing }
MidasContextEntities >> selectionNoFocus [
	selectionFrozen := true
]

{ #category : #accessing }
MidasContextEntities >> selectionToFocus [
	selectionFrozen := false
]

{ #category : #running }
MidasContextEntities >> toScope: aSymbol [
	^ self midasFocus collectNextGeneration:
		(MVSFilterManager new buildQueryBlockFrom: 'each toScope: ' , aSymbol).
	
]

{ #category : #accessing }
MidasContextEntities >> trackAssociation [
	resultsWithParents := true.
	self notifyMidasFocus: self midasFocus
]

{ #category : #running }
MidasContextEntities >> userSelection: selectedIndexes [
	| wasFrozen |
	selectedIndexes ifEmpty: [ ^ self ].
	wasFrozen := frozen.
	selectionFrozen ifTrue: [ frozen := true ].
	self midasFocus: (self computeNewFocus: selectedIndexes).
	frozen := wasFrozen.
]
