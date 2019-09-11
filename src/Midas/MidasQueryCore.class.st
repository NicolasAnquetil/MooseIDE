Class {
	#name : #MidasQueryCore,
	#superclass : #MidasQuery,
	#category : #'Midas-helpers'
}

{ #category : #accessing }
MidasQueryCore >> displayName [
	^ 'Core Entities'
]

{ #category : #accessing }
MidasQueryCore >> entities [
	^ (masterModel focusedEntities
		select:
			[ :each | (each atScope: FAMIXNamespace) mooseName asLowercase matchesRegex: '.*core.*'] )
		asCollection
]
