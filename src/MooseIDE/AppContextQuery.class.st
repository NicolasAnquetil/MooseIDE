Class {
	#name : #AppContextQuery,
	#superclass : #AppContextOptionalFocus,
	#category : #'MooseIDE-apps'
}

{ #category : #accessing }
AppContextQuery >> focus [ 
	^ focus ifNil: [ {self mooseModel}  ]
]

{ #category : #initialization }
AppContextQuery >> initialize [
	super initialize.
	frozen := true
]

{ #category : #initialization }
AppContextQuery >> unfreeze [ 
	"always frozen, cannot unfreeze"
]
