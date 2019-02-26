"
Abstract class for all stub entities
"
Class {
	#name : #StubEntity,
	#superclass : #Object,
	#instVars : [
		'entity'
	],
	#category : #'MooseIDE-stub'
}

{ #category : #accessing }
StubEntity class >> icon [
	^ '[ ]'
]

{ #category : #accessing }
StubEntity >> allChildren [
	^self children , (self children flatCollect: #allChildren)
]

{ #category : #accessing }
StubEntity >> children [
	self subclassResponsibility 
]

{ #category : #accessing }
StubEntity >> comment [
	^ '*no comment*'
]

{ #category : #accessing }
StubEntity >> entity: anEntity [
	entity := anEntity 
]

{ #category : #accessing }
StubEntity >> icon [
	^ self class icon
]

{ #category : #testing }
StubEntity >> isClass [
	^ false
]

{ #category : #testing }
StubEntity >> isMethod [
	^ false
]

{ #category : #testing }
StubEntity >> isModel [
	^ false
]

{ #category : #testing }
StubEntity >> isPackage [
	^ false
]

{ #category : #testing }
StubEntity >> isVariable [
	^ false
]

{ #category : #accessing }
StubEntity >> name [
	^ entity name
]

{ #category : #accessing }
StubEntity >> parent [
	self subclassResponsibility 
]

{ #category : #accessing }
StubEntity >> rootChildren [
	^ self children
]

{ #category : #accessing }
StubEntity >> sourceText [
	^ self name
]
