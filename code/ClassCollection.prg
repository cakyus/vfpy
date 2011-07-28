
&& @purpose emulator for Scripting.Dictionary

DEFINE CLASS ClassCollection AS ClassCustom

	DIMENSION Items[1]
	DIMENSION Keys[1]
	Count = 0
	
	FUNCTION Add
		LPARAMETERS lcKey, leVal
		LOCAL loText, loController
		
		This.Count = This.Count + 1
		
		IF PCOUNT() = 1 THEN
			leVal	= lcKey
			lcKey	= This.Count
		ENDIF
		
		
		DIMENSION This.Keys[This.Count]
		DIMENSION This.Items[This.Count]
		
		This.Keys[This.Count] = lcKey
		This.Items[This.Count] = leVal
	ENDFUNC
	
	FUNCTION Exists
		LPARAMETERS lcKey
		LOCAL lnCount
		
		FOR lnCount = 1 TO This.Count
			IF lcKey = This.Keys(lnCount) THEN
				RETURN .T.
			ENDIF
		ENDFOR
		RETURN .F.
	ENDFUNC
	
	FUNCTION Item
		LPARAMETERS lcKey
		LOCAL lnCount
		
		FOR lnCount = 1 TO This.Count
			IF lcKey = This.Keys(lnCount) THEN
				RETURN This.Items(lnCount)
			ENDIF
		ENDFOR
		
		RETURN .F.
	ENDFUNC
ENDDEF
