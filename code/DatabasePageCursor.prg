
&& @purpose cursor with page navigation support

DEFINE CLASS ClassDatabasePageCursor AS ClassCustom

	PageSize = 10
	PageNumber = 1
	PageCount = .NULL.
	RecordCount = 0
	
	CursorName = ""
	
	FUNCTION Init
		DODEFAULT()
		LOCAL loString
		loString = NEWOBJECT("ClassString")
		This.CursorName = loString.NewId()
	ENDFUNC
	
	FUNCTION GetCursor
		LOCAL loString
		LOCAL lcCursorName
		
		loString = NEWOBJECT("ClassString")
		lcCursorName = loString.NewId()
		
		This.Parent.Query.Limit((This.PageNumber - 1) * This.PageSize, This.PageSize)
		
		IF USED(This.CursorName) THEN
			This.Parent.Database.Query(This.Parent.Query.GetSql(), lcCursorName)
			SELECT (This.CursorName)
			ZAP
			APPEND FROM DBF(lcCursorName)
			GO TOP
			USE IN (lcCursorName)
			
		ELSE
			This.Parent.Database.Query(This.Parent.Query.GetSql(), This.CursorName)
		ENDIF
	ENDFUNC
	
	FUNCTION GetPageCount
		LOCAL loString
		LOCAL lcCursorName
		
		loString = NEWOBJECT("ClassString")
		lcCursorName = loString.NewId()

		This.Parent.Database.Query(This.Parent.Query.GetSqlRecordCount(), lcCursorName)
		IF USED(lcCursorName) THEN
			IF VARTYPE(&lcCursorName .Count1) = "C" THEN
				This.RecordCount = VAL(&lcCursorName .Count1)
			ELSE
				This.RecordCount = &lcCursorName .Count1
			ENDIF
			USE IN (lcCursorName)
			IF This.RecordCount > 0 THEN
				This.PageCount = CEILING(This.RecordCount / This.PageSize)
			ENDIF
		ENDIF
	ENDFUNC
	
	FUNCTION MoveFirst
		IF ISNULL(This.PageCount) THEN
			This.GetPageCount()
		ENDIF
		This.PageNumber = 1
		This.GetCursor()
	ENDFUNC
	
	FUNCTION MovePrevious
		IF ISNULL(This.PageCount) THEN
			This.GetPageCount()
		ENDIF
		IF This.PageNumber = 1 THEN
			RETURN .F.
		ENDIF
		This.PageNumber = This.PageNumber - 1
		This.GetCursor()
	ENDFUNC
	
	FUNCTION MoveNext
		IF ISNULL(This.PageCount) THEN
			This.GetPageCount()
		ENDIF
		IF This.PageNumber >= This.PageCount THEN
			RETURN .F.
		ENDIF
		This.PageNumber = This.PageNumber + 1
		This.GetCursor()
	ENDFUNC
	
	FUNCTION MoveLast
		IF ISNULL(This.PageCount) THEN
			This.GetPageCount()
		ENDIF
		This.PageNumber = This.PageCount
		This.GetCursor()
	ENDFUNC	
ENDDEF

