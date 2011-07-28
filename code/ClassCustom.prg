
DEFINE CLASS ClassCustom AS Custom

	FUNCTION Error
	
		LPARAMETERS lnError, lcMethod, lnLine
		LOCAL lcError

		DODEFAULT(lnError, lcMethod, lnLine)
		
		&& ASTACKINFO(laStackInfo)
		&& DISPLAY MEMORY LIKE laStackInfo TO FILE D:\STACKINFO.TXT
		
		lcError = 'Number : ' + ALLTRIM(STR(lnError))
		lcError = lcError + CHR(13) + CHR(10) + 'Message: ' + MESSAGE()
		lcError = lcError + CHR(13) + CHR(10) + 'Method: ' + lcMethod
		lcError = lcError + CHR(13) + CHR(10) + 'Class Name: ' + This.Name
		lcError = lcError + CHR(13) + CHR(10) + 'Class: ' + This.Class
		lcError = lcError + CHR(13) + CHR(10) + 'Base Class: ' + This.BaseClass
		lcError = lcError + CHR(13) + CHR(10) + 'Text: ' + MESSAGE(1)
		lcError = lcError + CHR(13) + CHR(10) + 'Line: ' + ALLTRIM(STR(lnLine))
		MESSAGEBOX(lcError)
		
	ENDFUNC
ENDDEF
