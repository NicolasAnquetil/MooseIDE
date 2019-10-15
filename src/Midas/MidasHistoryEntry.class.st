Class {
	#name : #MidasHistoryEntry,
	#superclass : #Object,
	#instVars : [
		'parent',
		'children',
		'value',
		'name'
	],
	#category : #'Midas-focusModel'
}

{ #category : #'instance creation' }
MidasHistoryEntry class >> with: anObject [
	^self new
		value: anObject ;
		yourself
]

{ #category : #accessing }
MidasHistoryEntry >> append: anObject [
	| entry |
	entry := MidasHistoryEntry with: anObject.
	entry parentEntry: self.
	children
		ifNil: [ children := (OrderedCollection new: 1) add: entry ; yourself ]
		ifNotNil: [children add: entry].
	^ entry
]

{ #category : #accessing }
MidasHistoryEntry >> entryName [
	^name ifNil: [ '' ]
]

{ #category : #accessing }
MidasHistoryEntry >> entryName: aString [
	name := aString
]

{ #category : #accessing }
MidasHistoryEntry >> hasNext [
	^children notNil
]

{ #category : #accessing }
MidasHistoryEntry >> hasPrevious [
	^parent notNil
]

{ #category : #accessing }
MidasHistoryEntry >> next [
	self hasNext ifFalse: [ ^ nil ].
	^children anyOne
]

{ #category : #accessing }
MidasHistoryEntry >> nextAt: anInt [
	(children size < anInt) ifTrue: [ ^ nil ].
	^children at: anInt
]

{ #category : #accessing }
MidasHistoryEntry >> nextEntries [
	^self hasNext
		ifTrue: [ children ]
		ifFalse: [ #() ]
]

{ #category : #accessing }
MidasHistoryEntry >> parentEntry: anEntry [
	parent := anEntry 
]

{ #category : #accessing }
MidasHistoryEntry >> prev [
	self hasPrevious ifFalse: [ ^ nil ].
	^parent
]

{ #category : #accessing }
MidasHistoryEntry >> summaryDescription [
	| stream size |
	stream := WriteStream on: String new.
	size := 0.
	value entities do: [ :entity |
			"all entries, except the first, start with a new line"
			size = 0 ifFalse: [ stream cr ].
			"if summary too long, put elipsis, otherwise add the entity name"
			size := size + entity midasDisplayString size.
			(size < 100)
				ifTrue: [ stream nextPutAll: entity midasDisplayString ]
				ifFalse: [
					stream nextPutAll: '...'.
					^ stream contents
				]
		 ].
	^stream contents
]

{ #category : #accessing }
MidasHistoryEntry >> value [
	^ value
]

{ #category : #accessing }
MidasHistoryEntry >> value: anObject [
	value := anObject 
]
