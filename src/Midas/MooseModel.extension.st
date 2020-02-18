Extension { #name : #MooseModel }

{ #category : #'*Midas' }
MooseModel >> allTags [
	^self privateState attributeAt: #allTags  ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #'*Midas' }
MooseModel >> resetTags [
	self privateState attributeAt: #allTags put: OrderedCollection new
]

{ #category : #'*Midas' }
MooseModel >> tagNamed: aString [
	|tags|
	tags := self allTags.
	^tags detect: [ :o | o name = aString ]
		ifNone: [ |tag|
			tag := FAMIXTag new.
			tag name: aString.
			tags add: tag.
			tag]
		
]
