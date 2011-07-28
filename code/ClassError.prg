
DEFINE CLASS ClassError AS ClassCustom

	Number				= 1098	&& user defined error
	Type				= "LOG"
		&& INFO			not error, notify user
		&& WARNING		error, program continued, notify user
		&& NOTICE		indicate error but it can be a normal condition
		&& 				, program continued, notify user
		&& ERROR		fatal error, program terminated, notify user
		&& LOG			just log the message, program continued, user not notified
	Description			= ""	&& error description
	Program				= ""
	LineNumber			= 0
	LineText			= ""
	HelpFile			= ""
	HelpContext			= ""
	
	IsDisplayError		= .F.
	
	FUNCTION Reset
		This.Number			= 1098
		This.Type			= "LOG"
		This.Description	= ""
		This.Program		= ""
		This.LineNumber		= 0
		This.LineText		= ""
		This.IsDisplayError	= .F.
	ENDFUNC
	
	FUNCTION ExportProperties
		LPARAMETERS loObject
		loObject.Number = This.Number
		loObject.Type = This.Type
		loObject.Description = This.Description
		loObject.Program = This.Program
		loObject.LineNumber = This.LineNumber
		loObject.LineText = This.LineText
		loObject.IsDisplayError = This.IsDisplayError
	ENDFUNC
	
	FUNCTION Type_Assign
		LPARAMETERS leValue
		IF INLIST(This.Type, "INFO", "WARNING", "NOTICE", "ERROR", "LOG") THEN
			This.Type = leValue
			IF INLIST(This.Type, "INFO", "WARNING", "NOTICE", "ERROR") THEN
				This.IsDisplayError = .T.
			ENDIF
		ELSE
			ERROR "unknown error type"
		ENDIF
	ENDFUNC
ENDDEF
