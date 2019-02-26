"
Stub entity for a Temporary variable
"
Class {
	#name : #StubVariable,
	#superclass : #StubEntity,
	#category : #'MooseIDE-stub'
}

{ #category : #accessing }
StubVariable class >> icon [
	^ '[V]'
]

{ #category : #accessing }
StubVariable >> children [
	^ #()
]

{ #category : #accessing }
StubVariable >> comment [
	^ ''
]

{ #category : #testing }
StubVariable >> isVariable [
	^ true
]

{ #category : #accessing }
StubVariable >> parent [
	^ self ownerMethod
]
