Class {
	#name : #TagMapLabeled,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'color',
		'base',
		'border',
		'rootEntities',
		'childrenBlock',
		'multiTagColorBlock',
		'noTagColorBlock'
	],
	#category : #Midas
}

{ #category : #accessing }
TagMapLabeled >> childrenBlock [
	"a block with one parameter: entity that return the list of children of this entity"
	^childrenBlock
]

{ #category : #accessing }
TagMapLabeled >> childrenBlock: aBlock [
	"a block with one parameter: entity that return the list of children of this entity"
	childrenBlock := aBlock
]

{ #category : #helpers }
TagMapLabeled >> childrenForEntity: anEntity [
	^ self childrenBlock value: anEntity 
]

{ #category : #running }
TagMapLabeled >> close: shape [
	shape children copy do: #remove.
	self update.
]

{ #category : #helpers }
TagMapLabeled >> colorFor: anEntity [
	anEntity allTags isEmpty
		ifTrue: [ ^ self noTagColorBlock value: anEntity ].
	anEntity allTags size = 1
		ifTrue: [ ^ anEntity allTags first color ].
	^ self multiTagColorBlock value: anEntity value: anEntity allTags
]

{ #category : #helpers }
TagMapLabeled >> defaultMultiTagColor [
	^ multiTagColorBlock := [ :entity :tags | tags anyOne color ]
]

{ #category : #helpers }
TagMapLabeled >> defaultNoTagColor [
	^ noTagColorBlock := [ :entity | Color lightGray ]
]

{ #category : #initialization }
TagMapLabeled >> initialize [
	super initialize.
	canvas := RSCanvas new.
	color := TSScale category20b.

	base := RSComposite new.
	base draggable.
	base @ (RSLabeled new model: [:rsElement | rsElement model name] ; yourself).
	base popup.
	base when: RSMouseClick do: [ :evt | self processEvent: evt ].

	border := RSBorder new.
	rootEntities := #().
	childrenBlock := [ :entity | #() ].
	self defaultNoTagColor.
	self defaultMultiTagColor.

]

{ #category : #accessing }
TagMapLabeled >> multiTagColorBlock [
	"aBlock with two parameters: entity and tags that returns the color for this entity"
	^ multiTagColorBlock
]

{ #category : #accessing }
TagMapLabeled >> multiTagColorBlock: aBlock [
	"aBlock with two parameters: entity and tags that returns the color for this entity"
	multiTagColorBlock := aBlock
]

{ #category : #accessing }
TagMapLabeled >> noTagColorBlock [
	"aBlock with one parameters, the entity without tags that returns the color for this entity"
	^ noTagColorBlock
]

{ #category : #accessing }
TagMapLabeled >> noTagColorBlock: aBlock [
	"aBlock with one parameters, the entity without tags that returns the color for this entity"
	noTagColorBlock := aBlock
]

{ #category : #helpers }
TagMapLabeled >> nodeFor: anEntity [
	| com |
	com := base copy.
	com model: anEntity.
	(self childrenForEntity: anEntity) ifNotEmpty: [ com border: border ].
	com announcer: base announcer.
	com color: (self colorFor: anEntity) trans.
	^ com
]

{ #category : #running }
TagMapLabeled >> open: shape [
	| children |
	children := (self childrenForEntity: shape model) 
						collect: [ :cls | self nodeFor: cls ].
	shape addAll: children.
	self update.
]

{ #category : #running }
TagMapLabeled >> processEvent: evt [
	| shape |
	shape := evt shape.
	shape children
		ifEmpty: [ self open: shape]
		ifNotEmpty: [ self close: shape ].
]

{ #category : #updating }
TagMapLabeled >> relayout: shape [
	(shape isKindOf: RSLabel) ifTrue: [ ^self ].
	"shape attributeAt: #original put: shape encompassingRectangle."

	shape shapes do: [ :s | self relayout: s ].
	RSGridLayout on: shape shapes.
	shape adjustToChildren.
	shape padding: 10.
]

{ #category : #accessing }
TagMapLabeled >> rootEntities [
	^rootEntities
]

{ #category : #accessing }
TagMapLabeled >> rootEntities: aCollection [
	rootEntities := aCollection
]

{ #category : #running }
TagMapLabeled >> run [
	rootEntities do: [:e | canvas add: (self nodeFor: e)].
	self update.
	canvas open
]

{ #category : #updating }
TagMapLabeled >> saveCurrent: shape [
	shape children do: [ :s | self saveCurrent: s].
	shape attributeAt: #current put: shape encompassingRectangle.
]

{ #category : #updating }
TagMapLabeled >> scale: shape at: t [
	| rect1 rect2 |
	shape children do: [ :s | self scale: s at: t ].
	rect1 := shape attributeAt: #original ifAbsent: [ ^ self].
	
	rect2 := shape attributeAt: #current.
	
		
	shape translateTo: (rect1 rsCenter interpolateTo: rect2 rsCenter at: t).
	
	shape extent: (rect1 extent interpolateTo: rect2 extent at: t)
]

{ #category : #updating }
TagMapLabeled >> update [
	| first |
	first := canvas shapes first.
	self relayout: first.
	"self saveCurrent: first."
	"canvas newAnimation
		onStepDo: [ :t |
			self scale: first at: t.
			canvas zoomToFit; signalUpdate. 
			 ]."
]
