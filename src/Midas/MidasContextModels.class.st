Class {
	#name : #MidasContextModels,
	#superclass : #MidasChildContext,
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextModels >> acceptStrongFocus: newFocus [
	^ false
]

{ #category : #notifications }
MidasContextModels >> acceptWeakFocus: newFocus [
	^ false
]

{ #category : #accessing }
MidasContextModels >> allModels [
	^ MooseModel root allModels
]

{ #category : #accessing }
MidasContextModels >> mooseModel: newMooseModel [
	parentContext mooseModel: newMooseModel

]
