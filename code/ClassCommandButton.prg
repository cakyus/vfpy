
DEFINE CLASS ClassCommandButton AS CommandButton

	FUNCTION Init
		DODEFAULT()
		LOCAL loTheme
		
		loTheme = NEWOBJECT("ClassTheme")
		loTheme.Theme(This, "COMMANDBUTTON")
	ENDFUNC
ENDDEF
