Class {
	#name : #MidasEntityAbstract,
	#superclass : #Object,
	#category : #'Midas-context'
}

{ #category : #formatting }
MidasEntityAbstract >> displayWithParent: aBoolean [
	self subclassResponsibility
]

{ #category : #formatting }
MidasEntityAbstract >> selection [
	self subclassResponsibility
]
