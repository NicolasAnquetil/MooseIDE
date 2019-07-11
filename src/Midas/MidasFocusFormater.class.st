Class {
	#name : #MidasFocusFormater,
	#superclass : #Object,
	#instVars : [
		'result'
	],
	#category : #'Midas-context'
}

{ #category : #formatting }
MidasFocusFormater >> format: anObject [
	result := OrderedCollection new.
	[	"using visitor infrastructure as a generic double dispatch mechanism"
		anObject accept: self]
		on: MessageNotUnderstood
		do: [ :err |
			((err message selector = #accept:)
				and: [(err receiver = anObject)
				and: [anObject isCollection]])
			ifTrue: [ self visitCollection: anObject]
			ifFalse: [ err signal ]
		].
	^result
]

{ #category : #formatting }
MidasFocusFormater >> virtualEntity: label from: col [
	col ifNotEmpty: [ | finalLbl |
		finalLbl := label , ' (' , col size asString , ')'.
		result add: (MidasEntityVirtual with: col named: finalLbl)
	]
]

{ #category : #visiting }
MidasFocusFormater >> visitClass: aClass [
	"using visitor infrastrcture as a generic double dispatch mechanism"
	self virtualEntity: 'Attributes' from: aClass attributes.
	self virtualEntity: 'Methods' from: aClass methods.

]

{ #category : #visiting }
MidasFocusFormater >> visitCollection: aCollection [
	"using visitor infrastrcture as a generic double dispatch mechanism"
	aCollection do: [ :each |
		result add: (MidasEntityTransparent with: each)
	]

]

{ #category : #visiting }
MidasFocusFormater >> visitMethod: aMethod [
	"using visitor infrastrcture as a generic double dispatch mechanism"
	self virtualEntity: 'Parameters' from: aMethod parameters.
	self virtualEntity: 'Local Variables' from: aMethod localVariables.

]

{ #category : #visiting }
MidasFocusFormater >> visitModel: aMooseModel [
	aMooseModel entityCache
		associationsDo: [ :assoc || label |
			label := assoc key asString.
			(label beginsWith: 'All model')
			ifTrue: [	self virtualEntity: label from: assoc value]
		]


]

{ #category : #visiting }
MidasFocusFormater >> visitNamespace: aNamespace [
	"using visitor infrastrcture as a generic double dispatch mechanism"
	self shouldBeImplemented 
]
