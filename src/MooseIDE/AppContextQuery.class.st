Class {
	#name : #AppContextQuery,
	#superclass : #AppContextOptionalFocus,
	#category : #'MooseIDE-apps'
}

{ #category : #accessing }
AppContextQuery >> focus [ 
	^ focus ifNil: [ {self mooseModel}  ]
]
