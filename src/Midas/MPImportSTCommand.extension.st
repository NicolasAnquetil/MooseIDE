Extension { #name : #MPImportSTCommand }

{ #category : #'*Midas' }
MPImportSTCommand >> execute [
	| models |
	models := MooseImportFromSmalltalkImageWizard new
		open;
		mooseModel.
	models ifNotNil: [ :model | self addModel: model ].
	^ models
]
