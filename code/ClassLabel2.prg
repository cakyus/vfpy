
DEFINE CLASS ClassLabel2 AS ClassContainer

	Caption = ""
	
	Visible = .T.
	
	ADD OBJECT Label1 AS ClassLabel

	FUNCTION Init
		LOCAL loTheme
		
		DODEFAULT()
	
		This.BorderWidth = 0
		This.BackStyle = 0
		
		loTheme = NEWOBJECT("ClassTheme")
		loTheme.Theme(This.Label1, "LABEL")
		
		This.Height = This.Label1.Height
		This.Label1.AutoSize = .T.
	ENDFUNC
	
	FUNCTION Caption_Assign
		LPARAMETERS leValue
		This.Label1.Caption = leValue
		This.Caption = leValue
		This.Width = This.Label1.Width
		This.Label1.Top = (This.Height - This.Label1.Height) / 2
	ENDFUNC
ENDDEF
