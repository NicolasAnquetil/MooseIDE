Class {
	#name : #AbstractTestMidasEntities,
	#superclass : #TestCase,
	#category : #'Midas-Tests'
}

{ #category : #accessing }
AbstractTestMidasEntities >> mockAssociation: aName [
	| mock |
	mock := Mock named: aName.
	mock stub isAssociation willReturn: true.
	^mock
]

{ #category : #accessing }
AbstractTestMidasEntities >> mockEntity: aName [
	| mock |
	mock := Mock named: aName.
	mock stub isAssociation willReturn: false.
	^mock
]
