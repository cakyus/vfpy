
DEFINE CLASS ClassErrors AS ClassError
	
	ADD OBJECT Items AS ClassCollection
	
	FUNCTION Add
		LOCAL loLog, loFormError, loError
		
		&& add information to log
		loLog = This.Parent.GetObject("ClassLog")
		loLog.Add(This)
		
		&& display message
		IF This.IsDisplayError = .T. THEN
			loFormError = This.Parent.GetForm("ClassFormError", This)
		ENDIF
		
		&& add into collection
		loError = This.Parent.GetObject("ClassError")
		This.ExportProperties(loError)
		This.Items.Add(loError)

		&& reset
		This.Reset()
	ENDFUNC
	
	FUNCTION Clear
	
	ENDFUNC
ENDDEF
