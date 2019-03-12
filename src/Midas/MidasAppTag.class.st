"
An app to set a tag on selected entities
"
Class {
	#name : #MidasAppTag,
	#superclass : #MidasAbstractApp,
	#instVars : [
		'entities',
		'lblNew',
		'newTag',
		'lblTags',
		'tags'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasAppTag class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newRow: [ :r | 
			r
				newColumn: [ :c1 | c1 add: #entities ];
				newColumn: [ :c2 | 
					c2
						newRow: [ :r21 | r21 add: #lblNew ] height: 30;
						newRow: [ :r22 | r22 add: #newTag ] height: 30;
						newRow: [ :r23 | r23 add: #lblTags ] height: 30;
						newRow: [ :r24 | r24 add: #tags ] ] ];
		yourself
]

{ #category : #specs }
MidasAppTag class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #accessing }
MidasAppTag >> entities [
	^ entities
]

{ #category : #initialization }
MidasAppTag >> initializeWidgets [
	super initializeWidgets.
	entities := (self instantiate: FastTablePresenter)
						displayBlock: [ :item | item name ] ;
						icons: [ :item | item mooseIcon ];
						sortingBlock: [ :a :b | a name < b name ] ;
						yourself.

	lblNew := self newLabel
		label: 'New tag named:';
		yourself.
	newTag := self newTextInput.
	lblTags := self newLabel
		label: 'Existing tags:';
		yourself.
	tags := self instantiate: FastTablePresenter
]

{ #category : #accessing }
MidasAppTag >> lblNew [
	^ lblNew
]

{ #category : #accessing }
MidasAppTag >> lblTags [
	^ lblTags
]

{ #category : #accessing }
MidasAppTag >> newTag [
	^ newTag
]

{ #category : #accessing }
MidasAppTag >> tags [
	^ tags
]

{ #category : #api }
MidasAppTag >> title [
	^ 'MIDAS Tag'
]

{ #category : #notifications }
MidasAppTag >> updateStrongFocus: newFocus [
	entities items: newFocus
]

{ #category : #notifications }
MidasAppTag >> updateWeakFocus: newFocus [
	self shouldNotImplement 

	
]
