Class {
	#name : #OldQueryTool,
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
OldQueryTool class >> defaultSpec [

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
OldQueryTool >> allEntityTypes: aCollection [
	^ (aCollection collect: [ :e | e class ]) asSet
]

{ #category : #accessing }
OldQueryTool >> entityTypes [
	^ entityTypes
]

{ #category : #initialization }
OldQueryTool >> initialExtent [
	^ (520@300)
]

{ #category : #initialization }
OldQueryTool >> initializeEntityTypes [
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
OldQueryTool >> initializeResult [
		result := self newList.

]

{ #category : #initialization }
OldQueryTool >> initializeUserScript [
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
OldQueryTool >> initializeWidgets [
	self initializeEntityTypes.
	self initializeUserScript.
	self initializeResult
]

{ #category : #display }
OldQueryTool >> open [
	entityTypes items:
		((self allEntityTypes: self currentEntity allChildren) sorted:
			[:a :b | a icon <= b icon]).
	super open
]

{ #category : #accessing }
OldQueryTool >> result [
	^ result
]

{ #category : #accessing }
OldQueryTool >> runBtn [
	^ runBtn
]

{ #category : #run }
OldQueryTool >> runScript: aString [
	result items:
		((Smalltalk compiler
			source: '[:c | c select: [:each | ' , aString , '] ]';
			evaluate) value: inputCollection)
]

{ #category : #accessing }
OldQueryTool >> selectLabel [
	^ selectLabel
]

{ #category : #accessing }
OldQueryTool >> userScript [
	^ userScript
]
