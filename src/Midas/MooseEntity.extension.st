Extension { #name : #MooseEntity }

{ #category : #'*Midas' }
MooseEntity >> addTag: aTag [
	(self allTags includes: aTag)
	ifTrue: [ ^ self ].
	self allTags add: aTag.
	aTag unsafeAddEntity: self
]

{ #category : #'*Midas' }
MooseEntity >> allTags [
	^self privateState propertyAt: #allTags ifAbsentPut: [ OrderedCollection new: 2 ]
]

{ #category : #'*Midas' }
MooseEntity >> allTags: aCollection [
	self allTags do: [ :t | t unsafeRemoveEntity: self ].
	self privateState propertyAt: #allTags put: [ OrderedCollection new: aCollection size ].
	aCollection do: [ :t | self addTag: t ]
]

{ #category : #'*Midas' }
MooseEntity >> removeTag: aTag [
	(self allTags includes: aTag)
	ifFalse: [ ^ self ].
	self allTags remove: aTag.
	aTag unsafeRemoveEntity: self
]
