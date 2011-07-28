SET DEFAULT TO LEFT(SYS(16),RAT('\', SYS(16)))

&& error handling
ON ERROR DO ErrorHandler WITH ERROR(), MESSAGE(), MESSAGE(1), PROGRAM(), LINENO(), SYS(2018)

Controller = NEWOBJECT("Controller")
Controller.Path = LEFT(SYS(16),RAT('\', SYS(16)))
Controller.Run()

FUNCTION ErrorHandler
	LPARAMETERS lnErrorNumber, lcMessage, lcLineText, lcFileName, lnLineNumber, lcParameter
	LOCAL lcError
	lcError = ALLTRIM(STR(lnErrorNumber)) + '. ' + lcMessage
	lcError = lcError + CHR(13) + CHR(10) + 'File: ' + lcFileName + ' (' + ALLTRIM(STR(lnLineNumber)) + ')'
	lcError = lcError + CHR(13) + CHR(10) + 'Text: ' + lcLineText
	MESSAGEBOX(lcError)
	DEBUG
	SUSPEND
ENDFUNC

