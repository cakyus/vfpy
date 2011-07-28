
DEFINE CLASS ClassDatabase AS ClassCustom
	
	Username = ""
	Password = ""
	Hostname = ""
	Database = ""
	PortNumber = 0

	Engine = "MYSQL"
	
	Handle = 0
	Connection = .NULL.
	ConnectionString = ""
	
	FUNCTION Init
		DODEFAULT()
		
		LOCAL loSingleton
		loSingleton = _SCREEN.Controls(1)
		This.Connection = loSingleton.GetObject("DatabaseConnectionDefault", "ClassDatabaseConnection")
		This.Connection.Open()
	ENDFUNC
	
	FUNCTION Open
		&& @purpose open new database connection
		&& @todo not avaliable yet
	ENDFUNC
	
	FUNCTION Exec
		LPARAMETERS lcSql
		
	ENDFUNC
	
	FUNCTION Query
		LPARAMETERS lcSql, lcCursorName
		
		WAIT WINDOWS "Executing remote query. Please wait .." NOWAIT NOCLEAR
		IF This.Connection.IsOpen = .F. THEN
			WAIT CLEAR
			ERROR "database is not open"
			RETURN .F.
		ENDIF
		
		
		IF SQLEXEC(This.Connection.Handle, lcSql, lcCursorName) < 0 THEN
			AERROR(arrError)
			IF arrError(1) = 1526
				WAIT CLEAR
				MESSAGEBOX(arrError(2))
				RETURN .F.
			ENDIF
		ENDIF
		WAIT CLEAR
	ENDFUNC
ENDDEF
