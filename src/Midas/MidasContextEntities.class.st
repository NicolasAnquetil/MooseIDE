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
	actuel := self strongFocus.
	actuel ifEmpty: [ ^ nil ].
	"hack to know whether we should go up (from methods -> atScope) or down (-> toScope)"
	actuel anyOne isMethod
		ifTrue: [ self strongFocus: (self atScope: 'FAMIXClass') ]
		ifFalse: [ self strongFocus: (self toScope: 'FAMIXClass') ].
]

{ #category : #accessing }
MidasContextEntities >> flattenResult [
	resultsWithParents := false.
	self notifyStrongFocus: nil
]

{ #category : #notifications }
MidasContextEntities >> formatNewModel: mooseModel [
	^ 	{MidasEntityTransparent with: mooseModel}
]

{ #category : #notifications }
MidasContextEntities >> formatNewStrongFocus: focus [
	(self focusIsMooseModel: focus)
		ifTrue: [ ^ {(MidasEntityTransparent with: focus)} ].
	focus isCollection
		ifTrue: [ ^ focus collect: [ :each | MidasEntityTransparent with: each ] ].
	^ {(MidasEntityTransparent with: focus)}
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
			self notifyStrongFocus: history now ]
		ifNotEmpty: [ aBlock := MVSFilterManager new buildQueryBlockFrom: aBlockAsString.
			self
				strongFocus:
					(app filterQuery
						ifTrue: [ self runSelectQuery: aBlock ]
						ifFalse: [ self runCollectQuery: aBlock ]) ]
]

{ #category : #running }
MidasContextEntities >> methodScope [
	self strongFocus: (self toScope: 'FAMIXMethod')
]

{ #category : #running }
MidasContextEntities >> packageScope [
	self strongFocus: (self atScope: 'FAMIXPackage')
]

{ #category : #accessing }
MidasContextEntities >> resultsWithParents [
	^resultsWithParents
]

{ #category : #running }
MidasContextEntities >> runCollectQuery: aBloc [
	^self strongFocus flatCollect: aBloc.

	
]

{ #category : #running }
MidasContextEntities >> runSelectQuery: aBloc [
	^ self strongFocus select: aBloc
]

{ #category : #notifications }
MidasContextEntities >> selectedStrongFocus: aMidasEntity [
	| wasFrozen |
	wasFrozen := frozen.
	frozen := false.
	self strongFocus: aMidasEntity selection.
	frozen := wasFrozen
]

{ #category : #running }
MidasContextEntities >> toScope: aSymbol [
	^ self runCollectQuery: (MVSFilterManager new buildQueryBlockFrom: 'each toScope: ' , aSymbol).
	
]

{ #category : #accessing }
MidasContextEntities >> trackAssociation [
	resultsWithParents := true.
	self notifyStrongFocus: nil
]
