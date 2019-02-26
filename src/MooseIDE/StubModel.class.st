"
Used to developed MooseLauncher without having a real MooseModel
"
Class {
	#name : #StubModel,
	#superclass : #StubEntity,
	#instVars : [
		'entities'
	],
	#category : #'MooseIDE-stub'
}

{ #category : #accessing }
StubModel >> allEntityTypes [
	^ StubEntity allSubclasses select: [ :c | c allInstances isNotEmpty ]
]

{ #category : #accessing }
StubModel >> allWithType: aType [
	^ aType allInstances
]

{ #category : #accessing }
StubModel >> children [
	^ self entities
]

{ #category : #metrics }
StubModel >> cyclomaticComplexity [
	^ ((self entities select: #isMethod) collect: #cyclomaticComplexity) average asFloat
]

{ #category : #accessing }
StubModel >> entities [
	entities ifNil: [ | pckg |
		entities := OrderedCollection new.
		pckg := StubPackage new entity: #MooseIDE asPackage.
		entities add: pckg.
		pckg classes do: [ :c |
			entities add: c.
			c methods do: [ :m |
				entities add: m.
				entities addAll: m variables
			].
			entities addAll: c instanceVariables
		]
	].
	^ entities
]

{ #category : #testing }
StubModel >> isModel [
	^ true
]

{ #category : #accessing }
StubModel >> name [
	^ 'MooseIDE model'
]

{ #category : #metrics }
StubModel >> numberOfClasses [
	^ (self entities select: #isClass) size
]

{ #category : #metrics }
StubModel >> numberOfLinesOfCode [
	^ ((self entities select: #isMethod) collect: #numberOfLinesOfCode) sum 
]

{ #category : #accessing }
StubModel >> rootChildren [
	^ self entities select: #isPackage
]

{ #category : #accessing }
StubModel >> sourceText [
	^ ''
]

{ #category : #metrics }
StubModel >> summarizingMetrics [
	^ #( numberOfLinesOfCode numberOfClasses cyclomaticComplexity )
]
