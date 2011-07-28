
DEFINE CLASS ClassLabelTextbox AS Textbox

	Visible = .T.
	Caption = ""

	FUNCTION Init
		DODEFAULT()
		LOCAL loTheme
		
		loTheme = NEWOBJECT("ClassTheme")
		loTheme.Theme(This, "LABELTEXTBOX")
		
		This.Enabled = .F.
		This.BackStyle = 0
		This.BorderStyle = 0
		This.DisabledForeColor = 0
	ENDFUNC
	
	FUNCTION Caption_Assign
		LPARAMETERS leValue
		This.Value = leValue
	ENDFUNC
ENDDEF
