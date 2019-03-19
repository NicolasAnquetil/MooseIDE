Extension { #name : #MMCMooseModelPresenter }

{ #category : #'*Midas' }
MMCMooseModelPresenter >> setSelectionTo: anItem [
	mooseModels resetSelection.
	mooseModels setSelectedItem: anItem
]
