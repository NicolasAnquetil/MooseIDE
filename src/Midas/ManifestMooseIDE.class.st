"
Experimental Moose IDE environment

Try it with: 

[ [ [ MidasLauncher openDefault ] ] ]
"
Class {
	#name : #ManifestMooseIDE,
	#superclass : #PackageManifest,
	#category : #'Midas-Manifest'
}

{ #category : #'code-critics' }
ManifestMooseIDE class >> ruleRBMissingSubclassResponsibilityRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#AbstractTestMidasEntities)) #'2019-10-09T11:55:17.894346+02:00') )
]
