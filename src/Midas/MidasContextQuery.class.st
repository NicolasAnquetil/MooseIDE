Class {
	#name : #MidasContextQuery,
	#superclass : #MidasChildContext,
	#category : #'Midas-appModel'
}

{ #category : #running }
MidasContextQuery >> atScope: aSymbol [
	^self midasFocus collectNextGeneration:
		(MVSFilterManager new buildQueryBlockFrom: 'each atScope: ' , aSymbol)
	
]

{ #category : #running }
MidasContextQuery >> interpretQuery: aBlockAsString [
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
