
DEFINE CLASS ClassTheme AS ClassCustom
	
	FontName = 'Trebuchet MS'
	FontSize = 12
	Enabled = .F.
	
	FUNCTION Theme
		LPARAMETERS loObject, lcType
		
		IF PCOUNT() = 1 THEN
			DO CASE
			CASE UPPER(loObject.BaseClass) = 'GRID'
				loObject.FontName = This.FontName
				loObject.FontSize = This.FontSize
			ENDCASE
		ELSE
			DO CASE
			CASE lcType = 'FORMMAIN'
				This.ThemeFormMain(loObject)
			CASE lcType = 'FORM'
				This.ThemeForm(loObject)
			CASE lcType = 'COMMANDBUTTON'
				This.ThemeCommandButton(loObject)
			CASE lcType = 'TEXTBOX'
				This.ThemeTextbox(loObject)
			CASE lcType = 'LABEL'
				This.ThemeLabel(loObject)
			CASE lcType = 'LABELTEXTBOX'
				This.ThemeLabelTextbox(loObject)
			ENDCASE
		ENDIF
	ENDFUNC
	
	FUNCTION ThemeLabel
		LPARAMETERS loObject
	
		loObject.FontName	= This.FontName
		loObject.FontSize	= This.FontSize + 4
		loObject.BackStyle	= 0 
		&& do not put autosize here
		loObject.Width = 115
		loObject.Height = 30
	ENDFUNC
	
	FUNCTION ThemeLabelTextbox
		LPARAMETERS loObject
	
		loObject.FontName	= This.FontName
		loObject.FontSize	= 14
		loObject.BackStyle	= 0 
		
		loObject.Width = 115
		loObject.Height = 30
	ENDFUNC
	
	FUNCTION ThemeFormMain
		LPARAMETERS loObject
		loObject.BackColor = 0
		&& loObject.Picture = 'background-main.bmp'
	ENDFUNC
	
	FUNCTION ThemeForm
		LPARAMETERS loObject
		loObject.BackColor = 15987699
		loObject.Picture = 'background.bmp'
	ENDFUNC
	
	FUNCTION ThemeCommandButton
		LPARAMETERS loObject
		loObject.FontName = This.FontName
		loObject.FontSize = This.FontSize + 2
		loObject.FontBold = .T.
		
		loObject.Width = 115
		loObject.Height = 30
				
		&& loObject.SpecialEffect = 2
		&& loObject.Style = 1 && invisible
	ENDFUNC
	
	FUNCTION ThemeTextbox
		LPARAMETERS loObject
		loObject.FontName = This.FontName
		loObject.FontSize = This.FontSize
			
		loObject.Width = 240
		loObject.Height = 30
	ENDFUNC
ENDDEF
