"
Context for AppQuery
Serves as an adapter for Honore's query window, so departs a bit for the overall infrastructure
For example, focuses are handled locally
"
Class {
	#name : #MidasContextQuery,
	#superclass : #MidasChildContext,
	#instVars : [
		'history',
		'focusStrong',
		'focusWeak',
		'activeFormPresenter'
	],
	#category : #'Midas-context'
}

{ #category : #accessing }
MidasContextQuery >> activeFormPresenter [
	^activeFormPresenter
]

{ #category : #accessing }
MidasContextQuery >> activeFormPresenter: aForm [
	^activeFormPresenter := aForm
]

{ #category : #adding }
MidasContextQuery >> addListener: aListener [
]

{ #category : #api }
MidasContextQuery >> doubleClickOn: anItem [
	parentContext strongFocus: anItem
]

{ #category : #api }
MidasContextQuery >> focus [
	^ focusWeak
]

{ #category : #api }
MidasContextQuery >> focus: entityCollection [
	focusWeak := entityCollection.
	self notifyWeakFocus: entityCollection 
]

{ #category : #utilities }
MidasContextQuery >> getProperties [
	^ focusWeak
		ifNil: [#() ]
		ifNotNil: [ :focus  | 
			focus ifNotEmpty: [ focus  first allDeclaredProperties]]
]

{ #category : #accessing }
MidasContextQuery >> history [
	^ history
]

{ #category : #accessing }
MidasContextQuery >> history: anObject [
	history := anObject
]

{ #category : #accessing }
MidasContextQuery >> mooseModel [
	^ focusStrong
		ifNil: [ parentContext mooseModel  cacheMooseGroups entityCache ]
		ifNotNil: [ 	(focusStrong isKindOf: MooseModel)
			ifTrue: [ focusStrong cacheMooseGroups entityCache ]
			ifFalse: [ focusStrong ].
 ]
]

{ #category : #accessing }
MidasContextQuery >> mooseModel: something [
	focusStrong := something.
	self notifyStrongFocus: something
]

{ #category : #notifications }
MidasContextQuery >> notifyNewModel: newMooseModel [
	"this context holds it own data, so store the model"
	self mooseModel: newMooseModel
]

{ #category : #notifications }
MidasContextQuery >> notifyStrongFocus: newFocus [
	frozen ifTrue: [ ^self ].
	(newFocus isKindOf: MooseModel)
		ifTrue: [ focusStrong := newFocus cacheMooseGroups entityCache ]
		ifFalse: [focusStrong := newFocus].
	app updateStrongFocus: focusStrong
]

{ #category : #notifications }
MidasContextQuery >> notifyWeakFocus: newFocus [
	^super notifyWeakFocus: newFocus
]

{ #category : #api }
MidasContextQuery >> performSearchWithParameters: aCollection [ 
	self shouldBeImplemented.
]
