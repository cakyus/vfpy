
DEFINE CLASS ClassForm AS Form

	ShowWindow = 1
	AutoCenter	= .T.
	Enabled = .T.
	WindowType = 1
	
	&& additional properties
	
	LogoPicture = "" && image which will be displayed at the left of ContainerTitleBar
	ControlPadding = 10
	
	FormMarginTop = 65
	FormMarginBottom = 15
	FormMarginLeft = 15
	FormMarginRight = 15
	
	ADD OBJECT ContainerTitleBar AS ClassFormContainerTitleBar
	
	FUNCTION Init
		DODEFAULT()
		
		This.TitleBar = 0
		This.BorderStyle = 0
		This.WindowState = 2
		
		&& pojok kanan atas
				
		LOCAL loTheme
		loTheme = NEWOBJECT("ClassTheme")
		loTheme.Theme(This, "FORM")
	ENDFUNC
	
	FUNCTION Activate
		DODEFAULT()
		This.Resize()
	ENDFUNC
	
	FUNCTION Resize
		DODEFAULT()
		
		This.ContainerTitleBar.Width = This.Width
		
		This.ContainerTitleBar.LabelCaption.Top = ;
			( This.ContainerTitleBar.Height - This.ContainerTitleBar.LabelCaption.Height ) / 2
		
		This.ContainerTitleBar.ImageClose.Left = ;
			This.ContainerTitleBar.Width - This.ContainerTitleBar.ImageClose.Width		
	ENDFUNC
	
	FUNCTION LogoPicture_Assign
		LPARAMETERS leValue
		This.LogoPicture = leValue
		This.ContainerTitleBar.ImageLogo.Picture = leValue
	ENDFUNC
	
	FUNCTION Caption_Assign
		LPARAMETER leValue
		This.Caption = leValue
		This.ContainerTitleBar.LabelCaption.Caption = leValue
	ENDFUNC
	
	FUNCTION Closable_Assign
		LPARAMETERS leValue
		This.Closable = leValue
		This.ContainerTitleBar.ImageClose.Visible = leValue
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
	
	FUNCTION MoveBottomRight
		LPARAMETERS loObjectRef, loObject
		loObject.Top = loObjectRef.Top + loObjectRef.Height + This.ControlPadding
		loObject.Left = loObjectRef.Left + loObjectRef.Width - loObject.Width
	ENDFUNC
	
	FUNCTION MoveRight
		LPARAMETERS loObjectRef, loObject
		loObject.Top = loObjectRef.Top
		loObject.Left = loObjectRef.Left + loObjectRef.Width + This.ControlPadding
	ENDFUNC
	
	FUNCTION MoveLeft
		LPARAMETERS loObjectRef, loObject
		loObject.Top = loObjectRef.Top
		loObject.Left = loObjectRef.Left - loObject.Width - This.ControlPadding
	ENDFUNC
	
	FUNCTION SizeWidth
		LPARAMETERS loObject, lnPercentage
		loObject.Width = This.Width - This.FormMarginLeft - This.FormMarginRight - loObject.Left
	ENDFUNC
	
	FUNCTION SizeHeight
		LPARAMETERS loObject, lnPercentage
		loObject.Height = This.Height - This.FormMarginTop - This.FormMarginBottom - loObject.Top
	ENDFUNC
ENDDEFINE
