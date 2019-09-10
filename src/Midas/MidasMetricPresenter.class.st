Class {
	#name : #MidasMetricPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'guiModel',
		'id',
		'submetric1',
		'submetric2',
		'submetric3',
		'metricName',
		'metricValue'
	],
	#category : #'Midas-apps'
}

{ #category : #specs }
MidasMetricPresenter class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: (SpecBoxLayout newVertical
					add: #metricName withConstraints: [ :c | c height: self defaultFont height ] ;
					add: #metricValue ;
					yourself);
		add:
			(SpecBoxLayout newHorizontal
				add: #submetric1 ;
				add: #submetric2 ;
				add: #submetric3 ;
				yourself ) ;
		yourself
]

{ #category : #specs }
MidasMetricPresenter class >> runMe [ 
<script>
self new openWithSpec 

]

{ #category : #accessing }
MidasMetricPresenter >> allValues [
	| values |
	values := OrderedCollection new: 4.
	values add: metricValue label.
	values add: submetric1 label.
	values add: submetric2 label.
	values add: submetric3 label.
	^ values
]

{ #category : #accessing }
MidasMetricPresenter >> guiModel: aGuiModel [
	guiModel := aGuiModel.
	metricName label: self myMetric displayName.
	submetric1  help: (guiModel subQuery: 1) displayName.
	submetric2  help: (guiModel subQuery: 2) displayName.
	submetric3  help: (guiModel subQuery: 3) displayName.

]

{ #category : #accessing }
MidasMetricPresenter >> id: aNumber [
	id := aNumber
]

{ #category : #initialization }
MidasMetricPresenter >> initializeWidgets [
	metricName := self newLabel emphasis: #bold.
	metricValue := self newButton.
	submetric1 := self newButton.
	submetric2 := self newButton.
	submetric3 := self newButton.
]

{ #category : #accessing }
MidasMetricPresenter >> mainMetricValue [
^metricValue
]

{ #category : #accessing }
MidasMetricPresenter >> myMetric [
	^ guiModel metric: id
]

{ #category : #accessing }
MidasMetricPresenter >> submetric: index [
	^ index == 1
		ifTrue: [ submetric1 ]
		ifFalse: [ index == 2
				ifTrue: [ submetric2 ]
				ifFalse: [ index == 3
						ifTrue: [ submetric3 ]
						ifFalse: [ nil ] ] ]
]

{ #category : #update }
MidasMetricPresenter >> update [
	self updateMainMetric.
	self updateSubmetrics
]

{ #category : #update }
MidasMetricPresenter >> updateMainMetric [
	| value |
	value := self myMetric aggregateMetricFor: guiModel focusedEntities.
	metricValue label: (value truncateTo: 0.001) asString
]

{ #category : #update }
MidasMetricPresenter >> updateSubmetric: index [
		| value |
		value := self myMetric aggregateMetricFor: (guiModel subQuery: index) entities.
		(self submetric: index)
			label: (value truncateTo: 0.001) asString
]

{ #category : #update }
MidasMetricPresenter >> updateSubmetrics [
	self updateSubmetric: 1.
	self updateSubmetric: 2.
	self updateSubmetric: 3.

]
