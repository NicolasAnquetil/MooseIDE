"
A TestResource class to allow calling 'SpecNullApplication reset.' after each Test class execution.
So it implements only a #tearDown

This allows the garbage collector to recover the instances of MidasLauncher created during the tests
	
"
Class {
	#name : #MidasTearDownTestsResource,
	#superclass : #TestResource,
	#category : #'Midas-Tests'
}

{ #category : #running }
MidasTearDownTestsResource >> tearDown [
	"to allow the garbage collector recovering the instances of MidasLauncher created during the tests"
	SpecNullApplication reset.
	super tearDown
]
