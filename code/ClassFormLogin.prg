
DEFINE CLASS ClassFormLogin AS ClassForm
	
	ADD OBJECT LabelUsername AS ClassLabelTextbox
	ADD OBJECT LabelPassword AS ClassLabelTextbox
	ADD OBJECT TextboxUsername AS ClassTextbox
	ADD OBJECT TextboxPassword AS ClassTextboxPassword
	ADD OBJECT CommandButtonLogin AS ClassCommandButton
	ADD OBJECT CommandButtonCancel AS ClassCommandButton
	
	FUNCTION Init
		DODEFAULT()
		LOCAL loTheme
		
		loTheme = NEWOBJECT("ClassTheme")
		
		This.Caption	= "Mlebu"
		This.LogoPicture = 'form-login.bmp'

		This.LabelUsername.Caption = "Username"
		This.LabelPassword.Caption = "Password"
		
		This.CommandButtonLogin.Caption = "Login"
		This.CommandButtonCancel.Caption = "Quit"
		
		This.MoveTop(This.LabelUsername)
		This.MoveRight(This.LabelUsername, This.TextboxUsername)
		This.MoveBottom(This.LabelUsername, This.LabelPassword)
		This.MoveBottom(This.TextboxUsername, This.TextboxPassword)
		This.MoveBottomRight(This.TextboxPassword, This.CommandButtonCancel)
		This.MoveLeft(This.CommandButtonCancel, This.CommandButtonLogin)
		
		This.Closable = .F.
		
		&& resize for to fit controls
		This.WindowState = 0
		This.Width = This.TextboxUsername.Width + This.LabelUsername.Width ;
			+ This.FormMarginLeft + This.FormMarginRight ;
			+ This.ControlPadding
		This.Height = This.CommandButtonLogin.Top + This.CommandButtonLogin.Height + This.FormMarginBottom
		This.AutoCenter = .T.
		
		loTheme.Theme(This, 'FROM')
	ENDFUNC
	
	FUNCTION CommandButtonLogin.Click
		LOCAL loUser
		loUser = NEWOBJECT("ClassUser")
		loUser.Username	= THISFORM.TextboxUsername.Value 
		loUser.Password = THISFORM.TextboxPassword.Value 
		IF loUser.Login() = .T. THEN
			THISFORM.Release()
		ENDIF
	ENDFUNC
		
	FUNCTION CommandButtonCancel.Click
		LOCAL loController
		loController = NEWOBJECT("Controller")
		loController.Quit()
	ENDFUNC
ENDDEF
