"
Context for the source code ""editor"".
Does not really edit, just show the code
"
Class {
	#name : #AppContextEditor,
	#superclass : #AppContext,
	#category : #'MooseIDE-apps'
}

{ #category : #accessing }
AppContextEditor >> focus [
	^ focus ifNil: [
		"a default value to ensure that there is some focus"
		self mooseModel allModelClasses first ]
]
