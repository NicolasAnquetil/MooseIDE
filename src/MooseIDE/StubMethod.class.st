"
Stub entity for a Method
"
Class {
	#name : #StubMethod,
	#superclass : #StubEntity,
	#instVars : [
		'parentClass'
	],
	#category : #'MooseIDE-stub'
}

{ #category : #accessing }
StubMethod class >> icon [
	^ '[M]'
]

{ #category : #accessing }
StubMethod >> children [
	^ self variables
]

{ #category : #metrics }
StubMethod >> cyclomaticComplexity [
	"not really accurate since will not count multiple instances of the same selector
	 but it answers something sensible which is enough for testing"
	^ (
		#( ifTrue: ifTrue:ifFalse: ifFalse:ifTrue: ifFalse:)
			select: [ :sel |
				entity hasSelector: sel ])
			size + 1
]

{ #category : #testing }
StubMethod >> isMethod [
	^ true
]

{ #category : #accessing }
StubMethod >> name [
	^ entity selector
]

{ #category : #metrics }
StubMethod >> numberOfLinesOfCode [
	^ self sourceText lines size
]

{ #category : #accessing }
StubMethod >> parent [
	^ self parentClass
]

{ #category : #accessing }
StubMethod >> parentClass [
	^ parentClass ifNil: [
		parentClass := StubClass new entity: entity methodClass ]
]

{ #category : #accessing }
StubMethod >> sourceText [
	^ entity sourceCode
]

{ #category : #accessing }
StubMethod >> variables [
	^ entity temporaryVariables collect: [ :v | StubVariable new entity: v ]
]
