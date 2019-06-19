Extension { #name : #MVSMSELoader }

{ #category : #'*Midas' }
MVSMSELoader class >> importModel [
	| fileRef |
	fileRef := self
		loadFileWithExtension: #('mse')
		andWindowTitle: 'Import model from MSE file'.
	fileRef isNotNil
		ifFalse: [ ^ nil ].
	MooseModel new
		installWithCache: true;
		importFromMSEStream: fileRef asFileReference readStream
]
