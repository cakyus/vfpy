
&& @purpose form utama aplikasi

DEFINE CLASS ClassFormMain AS Form

	AutoCenter = .T.
	Enabled = .T. 
	ShowWindow = 2		&& As Top-Level Form
	BorderStyle = 2
	ReleaseType = 2
	
	FUNCTION Init
		DODEFAULT()
		LOCAL loTheme
		loTheme = NEWOBJECT("ClassTheme")
		loTheme.Theme(This, "FORMMAIN")		
		
		This.MaxButton = .F.
	ENDFUNC
	
	FUNCTION Load
		DODEFAULT()
		LOCAL loVersion
		loVersion = NEWOBJECT("ClassVersion")
		This.WindowState = 2
		This.Caption = loVersion.Product + " - " + loVersion.Number
		This.Visible = .T.
	ENDFUNC
	
	FUNCTION Destroy
		DODEFAULT()
		CLEAR EVENTS 
	ENDFUNC 
ENDDEFINE
