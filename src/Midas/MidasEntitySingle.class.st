"
I am a MidasEntity with exactly one inner entity

When I don't understand something, I pass it through to my inner entity to see if it can handle it for me

"
Class {
	#name : #MidasEntitySingle,
	#superclass : #MidasEntityAbstract,
	#instVars : [
		'singleEntity'
	],
	#category : #'Midas-context'
}

{ #category : #'reflective operations' }
MidasEntitySingle >> doesNotUnderstand: aMessage [
	^ [ aMessage sendTo: singleEntity ]
		on: MessageNotUnderstood
		do: [ super doesNotUnderstand: aMessage ]
]

{ #category : #formatting }
MidasEntitySingle >> entities [
	^ { singleEntity }
]
