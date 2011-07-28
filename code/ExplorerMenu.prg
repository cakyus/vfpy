
DEFINE CLASS ClassExplorerMenu AS ClassMenu

	FUNCTION Init
		
		DODEFAULT()
		
		&& This.AddMenu(<ParentMenuName>, <MenuName>, <MenuLabel>)
		This.AddMenu("", "mnuFile", "File")
		This.AddMenu("mnuFile", "mnuFileUsers", "Users")
		This.AddMenu("mnuFile", "mnuFileLogout", "Logout ..")
		This.AddMenu("mnuFile", "mnuFileBar1")
		This.AddMenu("mnuFile", "mnuFileQuit", "\<Quit")

		&& This.AddMenu("", "mnuEdit", "Edit")
		&& This.AddMenu("mnuEdit", "mnuEditCut", "Cut")
		&& This.AddMenu("mnuEdit", "mnuEditCopy", "Copy")
		&& This.AddMenu("mnuEdit", "mnuEditPaste", "Paste")
		&& This.AddMenu("mnuEdit", "mnuEditBar1", "")
		&& This.AddMenu("mnuEdit", "mnuEditSelectAll", "Select All")

		This.AddMenu("", "mnuHelp", "Help")
		&& This.AddMenu("mnuHelp", "mnuHelpContent", "Content")
		This.AddMenu("mnuHelp", "mnuHelpBar1")
		This.AddMenu("mnuHelp", "mnuHelpAbout", "About")
	ENDFUNC
	
	FUNCTION mnuFileUsers
		LOCAL loUsersForm
		loUsersForm = NEWOBJECT("UsersForm")
		loUsersForm.Show()
	ENDFUNC
	
	FUNCTION mnuFileLogout
		LOCAL loUser
		loUser = NEWOBJECT("ClassUser")
		loUser.Logout()
		
		LOCAL loFormLogin
		loFormLogin = NEWOBJECT("ClassFormLogin")
		loFormLogin.Show()
	ENDFUNC
	
	FUNCTION mnuHelpAbout
		LOCAL loFormAbout
		loFormAbout = NEWOBJECT("ClassFormAbout")
		loFormAbout.Show()
	ENDFUNC
	
	FUNCTION mnuFileQuit
		THISFORM.Release()
	ENDFUNC
ENDDEF
