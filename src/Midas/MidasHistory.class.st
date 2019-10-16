"
A conveniance wrapper over NavigationHistory

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
	#category : #'Midas-focusModel'
}

{ #category : #adding }
MidasHistory >> addEntry: focus [
	current := self isEmpty
					ifTrue: [ entries := MidasHistoryEntry with: focus ]
					ifFalse: [ current append: focus]
]

{ #category : #adding }
MidasHistory >> addEntryModel: aMooseModel [
	current := entries := MidasHistoryEntry with: aMooseModel
]

{ #category : #accessing }
MidasHistory >> allEntries [
	| list todo entry |
	list := OrderedCollection new.
	todo := OrderedCollection new.
	todo add: self firstEntry.
	[ todo isEmpty ]
		whileFalse: [
			entry := todo first.
			todo remove: entry.
			list add: entry.
			todo addAll: entry nextEntries.
		].
	^list
]

{ #category : #accessing }
MidasHistory >> currentEntry [
	^current
]

{ #category : #accessing }
MidasHistory >> currentEntry: anHistoryEntry [
	current := anHistoryEntry 
]

{ #category : #accessing }
MidasHistory >> currentName [
	^current entryName
]

{ #category : #accessing }
MidasHistory >> currentName: aString [
	current entryName: aString
]

{ #category : #enumerating }
MidasHistory >> do: aBlock [
	self allEntries do: aBlock
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
MidasHistory >> removeEntry: anEntry [
	| parent |
	(anEntry = self firstEntry)
		ifTrue: ["cannot remove first entry"
			self currentEntry: anEntry.
			anEntry removeChildren.
			^self
		].

	parent := anEntry prev.
	(self currentEntry isDescendantOf: anEntry)
		ifTrue: [ self currentEntry: parent ].
	parent removeChild: anEntry
]

{ #category : #accessing }
MidasHistory >> size [
	^self allEntries size
]
