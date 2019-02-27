Class {
	#name : #AppContextOptionalFocus,
	#superclass : #AppContext,
	#category : #'MooseIDE-apps'
}

{ #category : #accessing }
AppContextOptionalFocus >> focus [ 
	^ focus ifNil: [ self mooseModel  ]
]
