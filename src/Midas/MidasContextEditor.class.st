"
Context for the source code ""editor"".
Does not really edit, just show the code
"
Class {
	#name : #MidasContextEditor,
	#superclass : #MidasChildContext,
	#category : #'Midas-appModel'
}

{ #category : #constants }
MidasContextEditor >> entityHasEmptySource [
	^ ' ** source for selection is empty **'
]

{ #category : #constants }
MidasContextEditor >> entityHasNoSource [
	^ ' ** no source for selection **'
]

{ #category : #notifications }
MidasContextEditor >> formatMidasFocus: newFocus [
	newFocus isModel
		ifTrue: [ ^ self modelHasNoSource ].
	newFocus isCollection
		ifTrue: [ ^ self entityHasNoSource ].

	newFocus singleEntity hasSourceAnchor
		ifFalse: [ ^self entityHasNoSource ].

	^newFocus singleEntity sourceText
		ifNil: [ self entityHasEmptySource ]
		ifNotNil: #yourself
]

{ #category : #constants }
MidasContextEditor >> modelHasNoSource [
	^ ' ** no source on models **'
]
