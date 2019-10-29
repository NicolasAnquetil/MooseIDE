Class {
	#name : #MidasPresenterEntities,
	#superclass : #SpPresenter,
	#instVars : [
		'lstEntities'
	],
	#category : #'Midas-appGUI'
}

{ #category : #specs }
MidasPresenterEntities class >> defaultSpec [
	^SpBoxLayout newVertical
		add: #lstEntities;
		yourself
]

{ #category : #api }
MidasPresenterEntities >> clearSelection [
	lstEntities unselectAll
]

{ #category : #api }
MidasPresenterEntities >> displayFocus: aCollection [
	lstEntities roots: aCollection.
	self clearSelection
]

{ #category : #initialization }
MidasPresenterEntities >> initializePresenter [
	lstEntities
		whenSelectionChangedDo: [ :selection |
			owner userSelection: selection selectedPaths
		].

]

{ #category : #initialization }
MidasPresenterEntities >> initializeWidgets [

	lstEntities 	:= self newTreeTable.
	lstEntities
		beMultipleSelection ;
		addColumn: (SpStringTableColumn new
							evaluated: #midasDisplayString ;
							yourself) ;
		children: [ :each | self owner childrenFor: each ]

]

{ #category : #menu }
MidasPresenterEntities >> listMenu [
	^ self newMenu
		addItem: [ :anItem | 
			anItem
				name: 'Inspect';
				icon: (self iconNamed: #smallInspectIt);
				action: [ lstEntities entities selectedItem inspect ] ]
]

{ #category : #accessing }
MidasPresenterEntities >> lstEntities [
	^ lstEntities
]

{ #category : #notifications }
MidasPresenterEntities >> selectPaths: paths [
	lstEntities selectPaths: paths 
]

{ #category : #accessing }
MidasPresenterEntities >> selectedPaths [
	^lstEntities selection selectedPaths
]
