
DEFINE CLASS UsersForm AS ClassForm

	ADD OBJECT TextboxSearch AS ClassTextbox
	ADD OBJECT LabelSearch AS ClassLabel2
	ADD OBJECT grdUsers AS ClassGridNavigator
	
	FUNCTION Init
		DODEFAULT()
		This.grdUsers.GetCursor("ClassUsersCursor")
	ENDFUNC
	
	FUNCTION Resize
		DODEFAULT()
		
		This.LogoPicture = "form-users.bmp"
		This.Caption = "Manage Users"
		This.LabelSearch.Caption = "Search"
		&& capitalize
		This.TextboxSearch.Format = "!"
		
		This.MoveTop(This.LabelSearch)
		This.MoveRight(This.LabelSearch, This.TextboxSearch)
		This.MoveBottom(This.LabelSearch, This.grdUsers)
		
		This.SizeWidth(This.TextboxSearch, 100)
		This.SizeWidth(This.grdUsers, 100)
		This.SizeHeight(This.grdUsers, 100)
	ENDFUNC
ENDDEF
