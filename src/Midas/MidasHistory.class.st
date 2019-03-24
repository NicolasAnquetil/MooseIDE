"
A conveniance wrapper over NavigatinHistory

Hides the fact that NavigationHistory stores entries with their insertion date

Also returns nil to first/last/current when empty
"
Class {
	#name : #MidasHistory,
	#superclass : #NavigationHistory,
	#category : #'Midas-context'
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
MidasHistory >> now [
	^super current key
]
