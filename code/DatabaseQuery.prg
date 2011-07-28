
DEFINE CLASS ClassDatabaseQuery AS ClassCustom

	TableName = ""
	LimitRecordCount = 0
	LimitOffset = 0
	
	FUNCTION Open
		LPARAMETERS lcTableName
		This.TableName = lcTableName
	ENDFUNC
	
	FUNCTION Limit
		LPARAMETERS lnOffset, lnLimitRecordCount
		This.LimitOffset = lnOffset
		This.LimitRecordCount = lnLimitRecordCount
	ENDFUNC
	
	FUNCTION GetSql
		LOCAL lcSqlSelect
		LOCAL lcSqlFrom
		LOCAL lcSqlWhere
		LOCAL lcSqlLimit
		
		lcSqlSelect = " SELECT * "
		lcSqlFrom = " FROM `" + This.TableName + "` "
		lcSqlWhere = ""
		
		IF This.LimitRecordCount > 0 OR This.LimitOffset > 0 THEN
			lcSqlLimit = " LIMIT " + ALLTRIM(STR(This.LimitOffset))
			lcSqlLimit = lcSqlLimit + ", " + ALLTRIM(STR(This.LimitRecordCount))
		ELSE
			lcSqlLimit = ""
		ENDIF
		
		RETURN lcSqlSelect + lcSqlFrom + lcSqlWhere + lcSqlLimit
	ENDFUNC
	
	FUNCTION GetSqlRecordCount
		LOCAL lcSqlSelect
		LOCAL lcSqlFrom
		LOCAL lcSqlWhere
		LOCAL lcSqlLimit
		
		lcSqlSelect = " SELECT COUNT(*) AS COUNT1 "
		lcSqlFrom = " FROM `" + This.TableName + "` "
		lcSqlWhere = ""
		
		IF This.LimitRecordCount > 0 OR This.LimitOffset > 0 THEN
			lcSqlLimit = " LIMIT " + ALLTRIM(STR(This.LimitOffset))
			lcSqlLimit = lcSqlLimit + ", " + ALLTRIM(STR(This.LimitRecordCount))
		ELSE
			lcSqlLimit = ""
		ENDIF
		
		RETURN lcSqlSelect + lcSqlFrom + lcSqlWhere + lcSqlLimit
	ENDFUNC
ENDDEF

