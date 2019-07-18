Class {
	#name : #TestCtxtLauncher,
	#superclass : #TestMidasCtxt,
	#category : #'Midas-Tests'
}

{ #category : #running }
TestCtxtLauncher >> setUp [
	| mockApp |
	super setUp.
	ctxt := MidasContextLauncher new.
	mockApp := Mock new.
	mockApp stub updateModel: nil.
	ctxt app: mockApp 
]

{ #category : #tests }
TestCtxtLauncher >> testMooseModel [
	self assert: ctxt mooseModel isNil.
	ctxt mooseModel: models first.
	self assert: ctxt mooseModel equals: models first.

]
