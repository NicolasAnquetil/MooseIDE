Class {
	#name : #MidasEntityFamix,
	#superclass : #MidasEntityAbstract,
	#instVars : [
		'famix',
		'children'
	],
	#category : #'Midas-context'
}

{ #category : #accessing }
MidasEntityFamix >> children: anObject [
	children := anObject
]

{ #category : #formatting }
MidasEntityFamix >> displayWithParent: aBoolean [
	^ aBoolean
		ifFalse: [ famix name ]
		ifTrue: [ '** must implement #formatWithParent: **' ]
]

{ #category : #accessing }
MidasEntityFamix >> entity: anObject [
	famix := anObject
]

{ #category : #initialization }
MidasEntityFamix >> initializeClass: aFamixClass [
	famix := aFamixClass.
	children := OrderedCollection new.
	self addVirtualChild: aFamixClass attributes named: 'Attributes'.
	self addVirtualChild: aFamixClass methods named: 'Methods'.

]

{ #category : #initialization }
MidasEntityFamix >> initializeModel: aMooseModel [
	famix := aMooseModel.
	children := OrderedCollection new.
	aMooseModel entityCache
		associationsDo: [ :assoc || label |
			label := assoc key asString.
			(label beginsWith: 'All model')
			ifTrue: [
				label := label , ' (' , assoc value size asString , ')'.
				self addVirtualChild: assoc value named: label	]
		]

]

{ #category : #accessing }
MidasEntityFamix >> selection [
	^ children
]
