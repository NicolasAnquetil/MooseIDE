Class {
	#name : #TestCtxtLauncher,
	#superclass : #TestMidasCtxt,
	#category : #'Midas-Tests'
}

{ #category : #tests }
TestCtxtLauncher >> testErrorInApp [
	"all children contexts get notified even in cas of errors"
	| childCtxt1 childCtxt2 childCtxt3 notified1 notified3 |
 	childCtxt1 := Mock new.
	(childCtxt1 stub notifyMidasFocus: Any)
		will: [ :arg | notified1 := true ].
	launcherCtxt addChild: childCtxt1.

	childCtxt2 := Mock new.
	(childCtxt2 stub notifyMidasFocus: Any)
		will: [ :arg | Error signal ].
	launcherCtxt addChild: childCtxt2.

 	childCtxt3 := Mock new.
	(childCtxt3 stub notifyMidasFocus: Any)
		will: [ :arg | notified3 := true ].
	launcherCtxt addChild: childCtxt3.

	notified1 := false.
	notified3 := false.
	launcherCtxt notifyMidasFocus: #someFocus.
	self assert: notified1.
	self assert: notified3
]

{ #category : #tests }
TestCtxtLauncher >> testMooseModel [
	self assert: (launcherCtxt mooseModel
						sameModel: models second)

]
