
DEFINE CLASS ClassString AS ClassCustom

	Caption = "Hello"

	FUNCTION NewId
		RETURN SYS(2015)
	ENDFUNC
	
	FUNCTION StrRepeat
		LPARAMETERS lcString, lnNumber
		LOCAL lnCount, lcReturn
		
		lcReturn = lcString
		lnCount = 0
		FOR lnCount = 1 TO lnNumber - 1
			lcReturn = lcReturn + lcString
		ENDFOR
		
		RETURN lcReturn
	ENDFUNC
ENDDEF

