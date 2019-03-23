Class {
	#name : #MidasContextQuery,
	#superclass : #MidasChildContext,
	#instVars : [
		'resultsWithParents'
	],
	#category : #'Midas-context'
}

{ #category : #running }
MidasContextQuery >> flattenResult [
	resultsWithParents := false.
]

{ #category : #initialization }
MidasContextQuery >> initialize [
	super initialize.
	resultsWithParents := false.
]

{ #category : #running }
MidasContextQuery >> runBlocQuery: aBloc  predicate: aSymbol [
	^self strongFocus perform: aSymbol with: aBloc.

	
]

{ #category : #running }
MidasContextQuery >> runQuery: stringQuery predicate: stringPredicate [
	| query |
	query := stringPredicate = 'filter'
					ifTrue: [ #select: ]
					ifFalse: [  #flatCollect: ].
	self notifyStrongFocus:
			(self runBlocQuery: (MVSFilterManager new buildQueryBlockFrom: stringQuery)
					preidcate: query)
	
]

{ #category : #running }
MidasContextQuery >> trackAssociation [
	resultsWithParents := true.
]
