"
A conveniance wrapper over NavigatinHistory

Hides the fact that NavigationHistory stores entries with their insertion date

Also returns nil to first/last/current when empty
"
Class {
	#name : #MidasHistory,
	#superclass : #NavigationHistory,
	#category : #'Midas-helpers'
}

{ #category : #accessing }
MidasHistory >> firstEntry [
	^self isEmpty
		ifTrue: [ nil ]
		ifFalse: [ storage first key ]
]

{ #category : #testing }
MidasHistory >> isEmpty [
	^ storage isEmpty
]

{ #category : #accessing }
MidasHistory >> lastEntry [
	^self isEmpty
		ifTrue: [ nil ]
		ifFalse: [ super last key ]
]

{ #category : #accessing }
MidasHistory >> next [
	^ super next key
]

{ #category : #history }
MidasHistory >> nextInHistory: entry [
	1 to: storage size do: [ :i |
		((storage at: i) key == entry)
		ifTrue: [
			(i < storage size)
			ifTrue: [ ^storage at: (i+1) ]
			ifFalse: [ ^nil ]
		]
	].
	^nil
	
]

{ #category : #accessing }
MidasHistory >> now [
	^super current key
]

{ #category : #accessing }
MidasHistory >> previous [
	^super previous key
]
