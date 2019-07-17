"
An app showing source code of currently selected entity
"
Class {
	#name : #MidasAppEditor,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'code'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppEditor class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #chkFreeze
			withConstraints: [ :constraints | constraints height: 30 ];
		add: #code;
		yourself
]

{ #category : #accessing }
MidasAppEditor >> code [
	^ code
]

{ #category : #constants }
MidasAppEditor >> entityHasEmptySource [
	^ ' ** source for selection is empty **'
]

{ #category : #constants }
MidasAppEditor >> entityHasNoSource [
	^ ' ** no source for selection **'
]

{ #category : #initialization }
MidasAppEditor >> initializeWidgets [
	super initializeWidgets.
	code := self newText
]

{ #category : #constants }
MidasAppEditor >> modelHasNoSource [
	^ ' ** no source on models **'
]

{ #category : #api }
MidasAppEditor >> title [
	^ 'MIDAS Source: ''' , context weakFocus name , ''''
]

{ #category : #notifications }
MidasAppEditor >> updateModel: aMooseModel [
	self updateTitle.
	code text: self modelHasNoSource
]

{ #category : #notifications }
MidasAppEditor >> updateStrongFocus: newFocus [
	self updateWeakFocus: newFocus
]

{ #category : #notifications }
MidasAppEditor >> updateWeakFocus: newFocus [
	self updateTitle.
	self flag: 'should test that the class or superclasses use FamixTWithSourceAnchor'.
	code text:
		(newFocus hasSourceAnchor
			ifFalse: [ self entityHasNoSource ]
			ifTrue: [
				newFocus sourceText
					ifNil: [ self entityHasEmptySource ]
					ifNotNil: #yourself])
]
