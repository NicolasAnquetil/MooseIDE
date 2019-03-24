"
An app to select entities from the current model
"
Class {
	#name : #MidasAppQuery,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'mnuHistory',
		'chkAssociation',
		'mnuSelcol',
		'lblEach',
		'fldQuery',
		'btnQuery',
		'lstEntities'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppQuery class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :c | 
			c
				newRow: [ :r |
					r
						add: #freeze ;
						add: #chkAssociation
					]  height: 30 ;
				add: #mnuHistory height: 30 ;
				newRow: [ :r |
					r
						add: #mnuSelcol width: 80 ;
						add: #lblEach width: 70 ;
						add: #fldQuery ;
						add: #btnQuery width: 30
					] height: 30 ;
				add: #lstEntities 
			] ;
		yourself
]

{ #category : #specs }
MidasAppQuery class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #accessing }
MidasAppQuery >> btnQuery [
	^ btnQuery
]

{ #category : #accessing }
MidasAppQuery >> chkAssociation [
	^ chkAssociation
]

{ #category : #accessing }
MidasAppQuery >> context: aContext [
	super context: aContext.
]

{ #category : #accessing }
MidasAppQuery >> fldQuery [
	^ fldQuery
]

{ #category : #initialization }
MidasAppQuery >> initializePresenter [
	chkAssociation
		whenActivatedDo: [ context trackAssociation ];
		whenDeactivatedDo: [ context flattenResult ].
	lstEntities
		whenSelectedItemChanged: [ :item | context selectedWeakFocus: item ] ;
		doubleClickAction: [ :item | context selectedStrongFocus: lstEntities selectedItem ]
]

{ #category : #initialization }
MidasAppQuery >> initializeWidgets [
	super initializeWidgets.

	chkAssociation := (self instantiate: CheckBoxPresenter)
		label: 'Track Parent' ;
		yourself.

	mnuHistory  := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Previous';
						icon: (self iconNamed: #smallUndoIcon);
						action: [ context prev ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Next';
						icon: (self iconNamed: #smallRedoIcon);
						action: [ context next ] ] ].
	mnuHistory applyTo: self.
	
	mnuSelcol  := self newDropList.
	mnuSelcol
		items: #(filter navigate) ;
		displayBlock: [ :i | i asString ].

	lblEach := self newLabel.
	lblEach label: 'each where:'.
	
	fldQuery := self newTextInput.
	
	btnQuery := self newButton.
	btnQuery label: 'run'.
	btnQuery action: self runQueryButtonAction.

	lstEntities := self instantiate: FastTablePresenter.
	lstEntities
		icons: [ :item | item mooseIcon ];
		sortingBlock: [ :a :b | a asString < b asString ]

]

{ #category : #accessing }
MidasAppQuery >> lblEach [
	^ lblEach
]

{ #category : #accessing }
MidasAppQuery >> lstEntities [
	^ lstEntities
]

{ #category : #accessing }
MidasAppQuery >> mnuHistory [
	^ mnuHistory
]

{ #category : #accessing }
MidasAppQuery >> mnuSelcol [
	^ mnuSelcol
]

{ #category : #initialization }
MidasAppQuery >> runQueryButtonAction [
	^[ context interpretQuery: mnuSelcol selectedItem withBody: fldQuery getText  ]
]

{ #category : #api }
MidasAppQuery >> title [
	^'MIDAS Query' 
]

{ #category : #notifications }
MidasAppQuery >> updateStrongFocus: focus [
	lstEntities items: (focus ifNil: [ #() ])
]

{ #category : #notifications }
MidasAppQuery >> updateWeakFocus: focus [
	lstEntities resetSelection.
	lstEntities setSelectedItem: focus
]
