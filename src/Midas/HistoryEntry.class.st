Class {
	#name : #HistoryEntry,
	#superclass : #Object,
	#instVars : [
		'parent',
		'children',
		'value',
		'name'
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
HistoryEntry >> entryName [
	^name ifNil: [ '' ]
]

{ #category : #accessing }
HistoryEntry >> entryName: aString [
	name := aString
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
	value isCollection ifFalse: [ ^ value name ].
	stream := WriteStream on: String new.
	size := 0.
	value do: [ :entity |
			"all entries except the first start a new line"
			size = 0 ifFalse: [ stream cr ].
			"if summary too long, put elipsis, otherwise add the entity name"
			size := size + entity name size.
			(size < 100)
				ifTrue: [ stream nextPutAll: entity name ]
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
