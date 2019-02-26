"
Stub entity for a Class
"
Class {
	#name : #StubClass,
	#superclass : #StubEntity,
	#instVars : [
		'subclasses',
		'methods',
		'instanceVariables',
		'package',
		'superclass'
	],
	#category : #'MooseIDE-stub'
}

{ #category : #accessing }
StubClass class >> icon [
	^ '[C]'
]

{ #category : #accessing }
StubClass >> children [
	^ (self subclasses , self instanceVariables , self methods) sorted: [ :e1 :e2 | e1 name <= e2 name ]
]

{ #category : #accessing }
StubClass >> comment [
	^ entity comment
]

{ #category : #accessing }
StubClass >> instanceVariables [
	instanceVariables ifNil: [
		instanceVariables := entity instanceVariables collect: [ :v | StubInstanceVariable new entity: v ] ].
	^ instanceVariables
]

{ #category : #testing }
StubClass >> isClass [
	^ true
]

{ #category : #accessing }
StubClass >> methods [
	methods ifNil: [
		methods := entity methods collect: [ :m | StubMethod new entity: m ] ].
	^ methods
]

{ #category : #accessing }
StubClass >> package [
	package ifNil: [ package := StubPackage new entity: entity package].
	^ package
]

{ #category : #accessing }
StubClass >> package: aPackage [
	package := aPackage
]

{ #category : #accessing }
StubClass >> parent [
	| superc pckg |
	superc := self superclass.
	pckg := self package.
	^(superc package name ~= pckg name)
		ifTrue: [ pckg ]
		ifFalse: [ superc]
]

{ #category : #accessing }
StubClass >> sourceText [
	^ entity superclass name , ' subclass: ' , self name , String cr ,
		'--' , String cr ,
		self comment
]

{ #category : #accessing }
StubClass >> subclasses [
	subclasses ifNil: [
		subclasses := entity allSubclasses collect: [ :c | StubClass new entity: c ] ].
	^ subclasses
]

{ #category : #accessing }
StubClass >> superclass [
	superclass ifNil: [
		superclass := StubClass new entity: entity superclass ].
	^ superclass
]
