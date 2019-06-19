Class {
	#name : #TestDashboardApp,
	#superclass : #TestMidas,
	#instVars : [
		'dashboardApp'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestDashboardApp >> setUp [
	super setUp.
	dashboardApp := launcherApp launchDashboardApp.
]
