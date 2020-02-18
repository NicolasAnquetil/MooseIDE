Class {
	#name : #MyDSM,
	#superclass : #RTDSM,
	#instVars : [
		'dependsCache'
	],
	#category : #Midas
}

{ #category : #accessing }
MyDSM >> dependants: p [
	^ dependsCache at: p
]

{ #category : #initialization }
MyDSM >> initialize [
	super initialize.
	dependency := [:e | self dependants: e].
	self shape
		if: [ :assoc | assoc key = assoc value ] fillColor: Color darkGray.
	
]

{ #category : #accessing }
MyDSM >> objects: aCollection [
	super objects: (aCollection sorted: [:a :b | a mooseName < b mooseName]).
	dependsCache := Dictionary new: aCollection size.
	aCollection do: [ :e |
		dependsCache at: e put: e providerNamespaces
	]
]
