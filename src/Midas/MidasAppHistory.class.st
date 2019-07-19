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
				add: #chkFreeze;
				add: #chkAssociation;
				add: #btnPrev;
				add: #btnNext)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add:
			(SpecBoxLayout newHorizontal
				add: #mnuSelcol
					withConstraints: [ :constraints | constraints width: 80 ];
				add: ' each where:'
					withConstraints: [ :constraints | constraints width: 75 ];
				add: #fldQuery;
				add: #btnQuery
					withConstraints: [ :constraints | constraints width: 30 ])
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #mnuScope
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #lstEntities;
		yourself
]

{ #category : #initialization }
MidasAppHistory >> initializeWidgetHistoryMenu [
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
