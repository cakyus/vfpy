
DEFINE CLASS ClassGrid AS Grid

	FUNCTION Init
		DODEFAULT()
		This.ReadOnly = .T.
		This.DeleteMark = .F.
		This.ScrollBars = 2
		This.Highlight = .F.
		This.HighlightRow = .F.
	ENDFUNC
	
	FUNCTION RecordSource_Assign
		LPARAMETERS leValue
		
		LOCAL lnCount
		LOCAL loTheme
		
		loTheme = NEWOBJECT("ClassTheme")
		loTheme.Theme(This)
		
		This.RecordSource = leValue
		FOR lnCount = 1 TO This.ColumnCount
			This.Columns(lnCount).Header1.FontName = loTheme.FontName
			This.Columns(lnCount).Header1.FontSize = loTheme.FontSize
			This.Columns(lnCount).Header1.FontBold = .T.
		NEXT
	ENDFUNC
ENDDEF
