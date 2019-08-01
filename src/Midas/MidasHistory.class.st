"
A conveniance wrapper over NavigatinHistory

Hides the fact that NavigationHistory stores entries with their insertion date

Also returns nil to first/last/current when empty
"
Class {
	#name : #MidasHistory,
	#superclass : #Object,
	#instVars : [
		'entries',
		'current'
	],
	#category : #'Midas-helpers'
}

{ #category : #adding }
MidasHistory >> addEntry: entities [
	current := self isEmpty
					ifTrue: [ entries := HistoryEntry with: entities ]
					ifFalse: [ current append: entities]
]

{ #category : #accessing }
MidasHistory >> currentEntry [
	^current
]

{ #category : #accessing }
MidasHistory >> currentEntry: anHistoryEntry [
	current := anHistoryEntry 
]

{ #category : #enumerating }
MidasHistory >> do: aBlock [
	| entry |
	entry := self firstEntry.
	[ entry isNil ]
		whileFalse: [
			aBlock value: entry.
			entry := entry next
		]
]

{ #category : #accessing }
MidasHistory >> entries [
	^entries
]

{ #category : #accessing }
MidasHistory >> firstEntry [
	^self isEmpty
		ifTrue: [ nil ]
		ifFalse: [ entries ]
]

{ #category : #testing }
MidasHistory >> hasNext [
	^current hasNext
]

{ #category : #testing }
MidasHistory >> hasPrevious [
	^current hasPrevious
]

{ #category : #testing }
MidasHistory >> isEmpty [
	^ entries isNil
]

{ #category : #accessing }
MidasHistory >> nextEntries [
	^current children
		ifEmpty: [ #() ]
		ifNotEmpty: #yourself
]

{ #category : #accessing }
MidasHistory >> nextEntry [
	| nxt |
	nxt := current next.
	^ nxt
		ifNil: [ nil ]
		ifNotNil: [ current := nxt ]

]

{ #category : #accessing }
MidasHistory >> previousEntry [
	| prv |
	prv := current prev.
	^ prv
		ifNil: [ nil ]
		ifNotNil: [ current := prv ]

]

{ #category : #accessing }
MidasHistory >> size [
	| tally |
	tally := 0.
	self do: [:each | tally := tally + 1].
	^ tally
]
