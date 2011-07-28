
DEFINE CLASS ClassUsersCursor AS ClassDatabaseCursor
	
	FUNCTION Init
		DODEFAULT()
		This.Query.Open("Users")
	ENDFUNC
ENDDEF
