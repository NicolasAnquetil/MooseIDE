"
For the MooseLauncher, the context contains the model on which it runs.
"
Class {
	#name : #LauncherContext,
	#superclass : #AppContext,
	#category : #'MooseIDE-apps'
}

{ #category : #accessing }
LauncherContext >> model [
	^ currentGroup
]
