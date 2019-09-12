"
Context for EntitiesApp
"
Class {
	#name : #MidasContextEntities,
	#superclass : #MidasChildContext,
	#instVars : [
		'resultsWithParents',
		'listEntities',
		'history'
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
MidasContextEntities >> focusOnSelection [
	self midasFocus: (app selectedItems)
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

{ #category : #running }
MidasContextEntities >> toScope: aSymbol [
	^ self runCollectQuery: (MVSFilterManager new buildQueryBlockFrom: 'each toScope: ' , aSymbol).
	
]

{ #category : #accessing }
MidasContextEntities >> trackAssociation [
	resultsWithParents := true.
	self notifyMidasFocus: nil
]

{ #category : #notifications }
MidasContextEntities >> userSelection: aCollection [
	"selecting entities does not change this selection"
	| wasFrozen |
	wasFrozen := frozen.
	frozen := true.
	self midasFocus: aCollection.
	frozen := wasFrozen
]
