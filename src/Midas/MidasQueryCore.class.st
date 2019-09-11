"
Concrete subclass of a MidasQuery that selects all entities belonging to a *core* namespace

"
Class {
	#name : #MidasQueryCore,
	#superclass : #MidasQuery,
	#category : #'Midas-helpers'
}

{ #category : #accessing }
MidasQueryCore class >> displayName [
	^ 'Core Entities'
]

{ #category : #accessing }
MidasQueryCore >> entities [
	^ (context focusedEntities
		select:
			[ :each | (each atScope: FAMIXNamespace) mooseName asLowercase matchesRegex: '.*core.*'] )
		asCollection
]
