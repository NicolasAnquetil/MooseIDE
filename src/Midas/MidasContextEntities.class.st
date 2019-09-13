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
	#category : #'Midas-context'
}

{ #category : #running }
MidasContextEntities >> atScope: aSymbol [
	^ (self runCollectQuery: (MVSFilterManager new buildQueryBlockFrom: 'each atScope: ' , aSymbol))
			removeDuplicates.
	
]

{ #category : #running }
MidasContextEntities >> classScope [
	| actuel |
	actuel := self midasFocus.
	actuel ifEmpty: [ ^ nil ].
	"hack to know whether we should go up (from methods -> atScope) or down (-> toScope)"
	actuel anyOne isMethod
		ifTrue: [ self midasFocus: (self atScope: 'FAMIXClass') ]
		ifFalse: [ self midasFocus: (self toScope: 'FAMIXClass') ].
]

{ #category : #accessing }
MidasContextEntities >> flattenResult [
	resultsWithParents := false.
	self notifyMidasFocus: nil
]

{ #category : #running }
MidasContextEntities >> focusOnSelection: aCollection [
	self midasFocus: (aCollection collect: #entities)
]

{ #category : #notifications }
MidasContextEntities >> formatMidasFocus: focus [
	(self focusIsMooseModel: focus)
		ifTrue: [ ^ {(MidasEntityTransparent with: focus)} ].
	focus isCollection
		ifTrue: [ ^ focus collect: [ :each | MidasEntityTransparent with: each ] ].
	^ {(MidasEntityTransparent with: focus)}
]

{ #category : #notifications }
MidasContextEntities >> formatNewModel: mooseModel [
	^ 	{MidasEntityTransparent with: mooseModel}
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
		ifEmpty: [
			self notifyMidasFocus: history now ]
		ifNotEmpty: [
			aBlock := MVSFilterManager new buildQueryBlockFrom: aBlockAsString.
			self
				midasFocus:
					(app filterQuery
						ifTrue: [ self runSelectQuery: aBlock ]
						ifFalse: [ self runCollectQuery: aBlock ]) ]
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

{ #category : #running }
MidasContextEntities >> runCollectQuery: aBloc [
	^self midasFocus flatCollect: aBloc.

	
]

{ #category : #running }
MidasContextEntities >> runSelectQuery: aBloc [
	^ self midasFocus select: aBloc
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
	^ self runCollectQuery: (MVSFilterManager new buildQueryBlockFrom: 'each toScope: ' , aSymbol).
	
]

{ #category : #accessing }
MidasContextEntities >> trackAssociation [
	resultsWithParents := true.
	self notifyMidasFocus: nil
]

{ #category : #running }
MidasContextEntities >> userSelection: aCollection [
	| wasFrozen |
	wasFrozen := frozen.
	selectionFrozen ifTrue: [ frozen := true ].
	self midasFocus: (aCollection collect:  #entities).
	frozen := wasFrozen.
]
