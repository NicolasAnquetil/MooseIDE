Class {
	#name : #MidasContextModels,
	#superclass : #MidasChildContext,
	#category : #'Midas-context'
}

{ #category : #notifications }
MidasContextModels >> acceptModelUpdate: newModel [
	^ true
]

{ #category : #notifications }
MidasContextModels >> acceptStrongFocusUpdate: newFocus [
	^ false
]

{ #category : #notifications }
MidasContextModels >> acceptWeakFocusUpdate: newFocus [
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
