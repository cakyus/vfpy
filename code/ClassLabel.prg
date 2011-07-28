
DEFINE CLASS ClassLabel AS Label

	Visible = .T.
	AutoSize = .T.

	FUNCTION Init
		LOCAL loTheme
		
		DODEFAULT()
		
		loTheme = NEWOBJECT("ClassTheme")
		loTheme.Theme(This, "LABEL")
	ENDFUNC
ENDDEF
