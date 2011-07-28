
DEFINE CLASS ClassExplorerForm AS ClassFormMain

	FUNCTION Init
		DODEFAULT()
		
		This.AddObject("ExplorerMenu", "ClassExplorerMenu")
		This.ExplorerMenu.Show()
		
		&& show login form
		&& This.ExplorerMenu.mnuFileLogout()
		
		This.ExplorerMenu.mnuFileUsers()
	ENDFUNC	
ENDDEFINE
