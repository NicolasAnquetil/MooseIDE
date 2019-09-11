"
An app showing source code of currently selected entity
"
Class {
	#name : #MidasAppEditor,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'code'
	],
	#category : #'Midas-gui'
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
	self canBeFrozen.
	code := self newText
]

{ #category : #constants }
MidasAppEditor >> modelHasNoSource [
	^ ' ** no source on models **'
]

{ #category : #api }
MidasAppEditor >> title [
	^ 'MIDAS Source: ''' , context midasFocus name , ''''
]

{ #category : #notifications }
MidasAppEditor >> updateMidasFocus: newFocus [
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

{ #category : #notifications }
MidasAppEditor >> updateModel: aMooseModel [
	super updateModel: aMooseModel.
	code text: self modelHasNoSource
]
