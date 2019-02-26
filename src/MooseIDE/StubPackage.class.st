Class {
	#name : #StubPackage,
	#superclass : #StubEntity,
	#instVars : [
		'classes'
	],
	#category : #'MooseIDE-stub'
}

{ #category : #accessing }
StubPackage class >> icon [
	^ '[P]'
]

{ #category : #accessing }
StubPackage >> children [
	
	^ self classes
]

{ #category : #accessing }
StubPackage >> classes [
	classes ifNil: [
		classes := entity classes
						collect: [ :c |
							StubClass new
								entity: c ;
								package: self ;
								yourself ]
	].
	^ classes
]

{ #category : #testing }
StubPackage >> isPackage [
	^ true
]

{ #category : #accessing }
StubPackage >> parent [
	^ nil
]

{ #category : #accessing }
StubPackage >> rootChildren [
	^ self classes select: [ :c | c superclass package name ~= self name ].
]
