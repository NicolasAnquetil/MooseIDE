Class {
	#name : #TestCtxtSystemComplex,
	#superclass : #AbstractTestMidasCtxt,
	#instVars : [
		'systCompCtxt'
	],
	#category : #'Midas-Tests'
}

{ #category : #running }
TestCtxtSystemComplex >> setUp [
	super setUp.
	systCompCtxt := launcherCtxt spawn: MidasContextSystemComplexity.
	systCompCtxt app: self mockEmptyApp.
]

{ #category : #tests }
TestCtxtSystemComplex >> testCheckResultAsTree [
	| displayUpdated |
	(mockApp stub displayFocus: Any) will: [ displayUpdated := true].

	displayUpdated := false.
	systCompCtxt focusBeHierarchical.
	self assert: displayUpdated.

	displayUpdated := false.
	systCompCtxt focusBeFlat.
	self assert: displayUpdated.
]

{ #category : #tests }
TestCtxtSystemComplex >> testSelectionInnerEntity [
	| highlighted selected |

	(mockApp stub highlight: Any) will: [ :arg | highlighted := arg ].

	systCompCtxt focusBeHierarchical.
	systCompCtxt unfreeze.
	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1 . #ancestor1 -> #child2}).

	selected := launcherCtxt midasFocus entities second. "i.e. mockEntity #child2"
	systCompCtxt userSelection: selected.

	self deny: systCompCtxt isFrozen.
	self assert: highlighted equals: { selected }
]

{ #category : #tests }
TestCtxtSystemComplex >> testSelectionOuterEntity [
	| highlighted selected |

	(mockApp stub highlight: Any) will: [ :arg | highlighted := arg ].

	systCompCtxt focusBeHierarchical.
	systCompCtxt unfreeze.
	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1 . #ancestor1 -> #child2}).

	selected := launcherCtxt midasFocus entities second. "i.e. mockEntity #child2"
	systCompCtxt userSelection: selected.

	self deny: systCompCtxt isFrozen.
	self assert: highlighted equals: { selected }
]

{ #category : #tests }
TestCtxtSystemComplex >> testSelectionResultFlatten [
	| highlighted selected |

	(mockApp stub highlight: Any) will: [ :arg | highlighted := arg ].

	systCompCtxt focusBeFlat.
	systCompCtxt unfreeze.
	launcherCtxt midasFocus:
		(self midasEntityCollection: { #ancestor1 -> #child1 . #ancestor1 -> #child2}).

	selected := launcherCtxt midasFocus entities second. "i.e. mockEntity #child2"
	systCompCtxt userSelection: selected.

	self deny: systCompCtxt isFrozen.
	self assert: highlighted equals: { selected }
]
