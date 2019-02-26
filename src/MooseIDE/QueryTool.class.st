Class {
	#name : #QueryTool,
	#superclass : #AbstractSpec,
	#instVars : [
		'entityTypes',
		'userScript',
		'result',
		'selectLabel',
		'runBtn',
		'inputCollection'
	],
	#category : #'MooseIDE-apps'
}

{ #category : #specs }
QueryTool class >> defaultSpec [

	^ SpecLayout composed
		newRow: [ :r |
			r add: #entityTypes width: 200.
			r
				newColumn: [ :c |
					c
						newRow: [:r2 |
							r2
								add: #selectLabel width: 75 ;
								add: #userScript ;
								add: #runBtn width: 30
						]
						height: 25.
					c add: #result ]
				width: 300.
		]
		yourself
]

{ #category : #accessing }
QueryTool >> allEntityTypes: aCollection [
	^ (aCollection collect: [ :e | e class ]) asSet
]

{ #category : #accessing }
QueryTool >> entityTypes [
	^ entityTypes
]

{ #category : #initialization }
QueryTool >> initialExtent [
	^ (520@300)
]

{ #category : #initialization }
QueryTool >> initializeEntityTypes [
	entityTypes := self newList.
	entityTypes displayBlock:
		[ :aType | aType icon , ' ' , aType name , ' (' , aType allInstances size asString , ')' ].
	entityTypes 	whenSelectedItemChanged: [ :anEntity | 
		context currentEntity: anEntity.
		anEntity
			ifNil: [ inputCollection := OrderedCollection new ]
			ifNotNil: [ inputCollection := anEntity allInstances ] ]
]

{ #category : #initialization }
QueryTool >> initializeResult [
		result := self newList.

]

{ #category : #initialization }
QueryTool >> initializeUserScript [
	selectLabel := self newLabel: 'select: [:each|'.

	userScript := self newTextInput.
	userScript
		ghostText: '...';
		autoAccept: false ;
		acceptOnCR: true ;
		acceptBlock: [:script | self runScript: script ].

	runBtn := self newButton.
	runBtn
		label: 'run' ;
		state: false ;
		action: [self runScript: userScript getText ].
]

{ #category : #initialization }
QueryTool >> initializeWidgets [
	self initializeEntityTypes.
	self initializeUserScript.
	self initializeResult
]

{ #category : #display }
QueryTool >> open [
	entityTypes items:
		((self allEntityTypes: self currentEntity allChildren) sorted:
			[:a :b | a icon <= b icon]).
	super open
]

{ #category : #accessing }
QueryTool >> result [
	^ result
]

{ #category : #accessing }
QueryTool >> runBtn [
	^ runBtn
]

{ #category : #run }
QueryTool >> runScript: aString [
	result items:
		((Smalltalk compiler
			source: '[:c | c select: [:each | ' , aString , '] ]';
			evaluate) value: inputCollection)
]

{ #category : #accessing }
QueryTool >> selectLabel [
	^ selectLabel
]

{ #category : #accessing }
QueryTool >> userScript [
	^ userScript
]
