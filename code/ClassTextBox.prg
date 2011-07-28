
DEFINE CLASS ClassTextbox AS Textbox

	Visible = .T.
	Caption = ""
	
	FUNCTION Init
		DODEFAULT()
		
		LOCAL loTheme
		loTheme = NEWOBJECT("ClassTheme")
		loTheme.Theme(This, "TEXTBOX")
		
	ENDFUNC
	
	FUNCTION GotFocus
		DODEFAULT()
		This.BackColor = 65535
	ENDFUNC
	
	FUNCTION LostFocus
		DODEFAULT()
		This.BackColor = 16777215
	ENDFUNC
ENDDEF

