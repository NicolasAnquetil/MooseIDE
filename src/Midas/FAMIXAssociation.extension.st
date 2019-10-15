Extension { #name : #FAMIXAssociation }

{ #category : #'*Midas' }
FAMIXAssociation >> associationPrintName [
	self subclassResponsibility 
]

{ #category : #'*Midas' }
FAMIXAssociation >> midasDisplayString [
	| str |
	str := String new writeStream.
	str
		<< self associationPrintName ;
		<< ':' ;
		<< (self from midasDisplayString) ;
		<< '->' ;
		<< (self to midasDisplayString).
	^str contents
]
