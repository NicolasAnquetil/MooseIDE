Class {
	#name : #MidasAppHistory,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'btnPrev',
		'btnNext'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppHistory class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
				add: #btnPrev;
				add: #btnNext)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		yourself
]

{ #category : #initialization }
MidasAppHistory >> initializeWidgets [
	btnPrev := self newButton.
	btnPrev
		disable ;
		icon: (self iconNamed: #smallUndoIcon);
		action: [ context prev ].
	btnNext := self newButton.
	btnNext
		disable ;
		icon: (self iconNamed: #smallRedoIcon);
		action: [ context next ].

]

{ #category : #notifications }
MidasAppHistory >> updatePreviousNext [
	btnPrev
		enabled: (context historyHasPrevious).
	btnNext enabled: (context historyHasNext)
]

{ #category : #notifications }
MidasAppHistory >> updateStrongFocus: focus [
	self updatePreviousNext
]

{ #category : #notifications }
MidasAppHistory >> updateWeakFocus: focus [
	self subclassResponsibility 
]
