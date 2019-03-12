"
Context for the source code ""editor"".
Does not really edit, just show the code
"
Class {
	#name : #MidasContextEditor,
	#superclass : #MidasContext,
	#category : #'Midas-context'
}

{ #category : #accessing }
MidasContextEditor >> strongFocus [
	^ focusStrong
		ifNil:
			[ "a default value to ensure that there is some focus" self mooseModel allModelClasses first ]
]
