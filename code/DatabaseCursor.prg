
DEFINE CLASS ClassDatabaseCursor AS ClassCustom

	CursorName = ""
	
	ADD OBJECT Database AS ClassDatabase
	ADD OBJECT Query AS ClassDatabaseQuery
	ADD OBJECT Page AS ClassDatabasePageCursor
	
	FUNCTION GetCursor
		LOCAL loDatabase, loString
		
		loString = NEWOBJECT("ClassString")
		
		This.CursorName = loString.NewId()
		loDatabase.Query(This.Query.GetSql(), This.CursorName)
	ENDFUNC
ENDDEF

