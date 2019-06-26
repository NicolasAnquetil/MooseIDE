Class {
	#name : #BaselineOfMidas,
	#superclass : #BaselineOf,
	#category : #BaselineOfMidas
}

{ #category : #baseline }
BaselineOfMidas >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec preLoadDoIt: #verifyMooseInstalled.
			"Packages"
			spec
				baseline: 'MetricDashboard'
				with: [ spec repository: 'github://570gina/MetricDashboard/src' ].
			spec
				baseline: 'MooseMetricCalculator'
				with: [ spec repository: 'github://mahugnon/MooseMetricCalculator/src' ].
			spec
				baseline: 'VisuProject'
				with: [ spec repository: 'github://mahugnon/VisuProject:bazader/src' ].
			spec package: 'Midas' with: [ spec requires: #('MetricDashboard' 'MooseMetricCalculator' 'VisuProject') ] ]
]

{ #category : #accessing }
BaselineOfMidas >> projectClass [
	^ MetacelloCypressBaselineProject
]

{ #category : #baseline }
BaselineOfMidas >> verifyMooseInstalled [
	self class environment
		at: #MooseModel
		ifAbsent: [ UIManager default
				abort:
					'Moose must be installed prior to loading Midas. The baseline doesn''t load it because it''s big. We recommend loading it from the GitHub repo, or starting with a Moose image from Pharo Launcher.' ]
]
