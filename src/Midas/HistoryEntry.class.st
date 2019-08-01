Class {
	#name : #HistoryEntry,
	#superclass : #Object,
	#instVars : [
		'parent',
		'children',
		'value'
	],
	#category : #'Midas-helpers'
}

{ #category : #'instance creation' }
HistoryEntry class >> with: anObject [
	^self new
		value: anObject ;
		yourself
]

{ #category : #accessing }
HistoryEntry >> append: anObject [
	| entry |
	entry := HistoryEntry with: anObject.
	entry parentEntry: self.
	children ifNil: [ children := OrderedCollection with: entry ] ifNotNil: [children add: entry].
	^ entry
]

{ #category : #accessing }
HistoryEntry >> hasNext [
	^children notNil
]

{ #category : #accessing }
HistoryEntry >> hasPrevious [
	^parent notNil
]

{ #category : #accessing }
HistoryEntry >> next [
	self hasNext ifFalse: [ ^ nil ].
	^children anyOne
]

{ #category : #accessing }
HistoryEntry >> nextAt: anInt [
	(children size < anInt) ifTrue: [ ^ nil ].
	^children at: anInt
]

{ #category : #accessing }
HistoryEntry >> nextEntries [
	^self hasNext
		ifTrue: [ children ]
		ifFalse: [ #() ]
]

{ #category : #accessing }
HistoryEntry >> parentEntry: anEntry [
	parent := anEntry 
]

{ #category : #accessing }
HistoryEntry >> prev [
	self hasPrevious ifFalse: [ ^ nil ].
	^parent
]

{ #category : #accessing }
HistoryEntry >> summaryDescription [
	| stream size |
	stream := WriteStream on: String new.
	size := 0.
	value
		do: [ :entity | 
			size := size + entity name size.
			(size < 100)
				ifTrue: [
					stream nextPutAll: entity name.
					stream cr
				]
			ifFalse: [
				stream nextPutAll: '...'.
				^ stream contents
			]
		 ].
	^stream contents
]

{ #category : #accessing }
HistoryEntry >> value [
	^ value
]

{ #category : #accessing }
HistoryEntry >> value: anObject [
Halt if: [ anObject isKindOf: HistoryEntry ].
	value := anObject 
]
