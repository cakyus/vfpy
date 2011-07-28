
DEFINE CLASS ClassSingleton AS ClassCustom
	
	FUNCTION GetObject
		LPARAMETERS lcObjectName, lcClassName
		LOCAL lnCount, lbFound
		
		FOR lnCount = 1 TO _SCREEN.ControlCount
			IF _SCREEN.Controls(lnCount).Name = lcObjectName THEN
				RETURN _SCREEN.Controls(lnCount)
			ENDIF
		ENDFOR
		
		_SCREEN.AddObject(lcObjectName, lcClassName)
		RETURN _SCREEN.Controls(_SCREEN.ControlCount)
	ENDFUNC
ENDDEF
