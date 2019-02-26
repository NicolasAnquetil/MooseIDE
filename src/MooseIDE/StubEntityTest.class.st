Class {
	#name : #StubEntityTest,
	#superclass : #TestCase,
	#category : #'MooseIDE-test'
}

{ #category : #tests }
StubEntityTest >> testAllChildren [
	|clazz|
	clazz := StubClass new entity: StubInstanceVariable.
	self assert: clazz allChildren size equals: 1.
	self assert: clazz allChildren anyOne name equals: 'name'.

	clazz := StubClass new entity: StubVariable.
	self assert: clazz allChildren size equals: 6.
	self assert: (clazz allChildren select: #isMethod) size equals: 5.
	self assert: (clazz allChildren select: #isClass) size equals: 1.

	clazz := StubClass new entity: StubPackage.
	self assert: clazz allChildren size equals: 6.
	self assert: (clazz allChildren select: #isMethod) size equals: 5.
	self assert: (clazz allChildren select: #isVariable) size equals: 1.
]
