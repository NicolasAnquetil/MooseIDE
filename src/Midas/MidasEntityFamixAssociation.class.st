Class {
	#name : #MidasEntityFamixAssociation,
	#superclass : #MidasEntityCollection,
	#category : #'Midas-focusModel'
}

{ #category : #'instance creation' }
MidasEntityFamixAssociation >> nextGenerationFromCollect: aBlock [
	"For Associations, we want the ancestor of the next generation to be the ancestor
	 of the association, not the association itself"
	^self nextGenerationFromCollection:
		(self entitiesWithAncestors flatCollect: [ :assoc |
			assoc value collect: [ :each | assoc key -> (aBlock value: each) ]
		])

]
