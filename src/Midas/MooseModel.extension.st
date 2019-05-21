Extension { #name : #MooseModel }

{ #category : #'*Midas' }
MooseModel >> accept: aVisitor [
	^ aVisitor visitModel: self
]
