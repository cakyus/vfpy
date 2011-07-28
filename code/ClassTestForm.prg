
DEFINE CLASS ClassTestForm AS Form

	ShowWindow = 1
	AutoCenter	= .T.
	Enabled = .T.
	Visible = .T.
	WindowType = 1
	
	ControlPadding = 10
	
	FormMarginTop = 65
	FormMarginBottom = 65
	FormMarginLeft = 15
	FormMarginRight = 15
	
	ADD OBJECT FormCloseButton AS ClassImage
	ADD OBJECT FormLabelCaption AS ClassLabel
	
	FUNCTION Init
		DODEFAULT()
		
		This.TitleBar = 0
		This.BorderStyle = 0
		This.WindowState = 2
		
		* pojok kanan atas
		This.FormCloseButton.Picture = 'button-close.jpg'
		This.FormCloseButton.Left = _APP.ActiveForm.Width - This.FormCloseButton.Width
		
				
		LOCAL loTheme
		loTheme = _APP.GetObject('ClassTheme')
		loTheme.Theme(This, 'FORM')
		
		This.FormLabelCaption.FontName = loTheme.FontName
		This.FormLabelCaption.FontSize = loTheme.FontSize + 10
		This.FormLabelCaption.FontBold = .T.
		This.FormLabelCaption.Left = This.FormMarginLeft
		This.FormLabelCaption.Top = (This.FormMarginTop - This.FormLabelCaption.Height) / 2
	ENDFUNC
	
	FUNCTION Caption_Assign
		LPARAMETER leValue
		This.Caption = leValue
		This.FormLabelCaption.Caption = leValue
	ENDFUNC
	
	FUNCTION Closable_Assign
		LPARAMETERS leValue
		This.Closable = leValue
		This.FormCloseButton.Visible = leValue
	ENDFUNC
	
	FUNCTION FormCloseButton.Click
		This.Parent.Release()
	ENDFUNC
	
	FUNCTION MoveTop
		LPARAMETERS loObject
		loObject.Top = This.FormMarginTop
		loObject.Left = This.FormMarginLeft
	ENDFUNC
	
	FUNCTION MoveBottom
		LPARAMETERS loObjectRef, loObject
		loObject.Top = loObjectRef.Top + loObjectRef.Height + This.ControlPadding	
		loObject.Left = loObjectRef.Left
	ENDFUNC
	
	FUNCTION MoveRight
		LPARAMETERS loObjectRef, loObject
		loObject.Top = loObjectRef.Top
		loObject.Left = loObjectRef.Left + loObjectRef.Width + This.ControlPadding
	ENDFUNC
	
	FUNCTION SizeWidth
		LPARAMETERS loObject, lnPercentage
		loObject.Width = This.Width - This.FormMarginLeft - This.FormMarginRight 
	ENDFUNC
	
	FUNCTION SizeHeight
		LPARAMETERS loObject, lnPercentage
		loObject.Height = This.Height - This.FormMarginTop - This.FormMarginBottom
	ENDFUNC
ENDDEFINE
