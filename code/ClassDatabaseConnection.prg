
&& @todo read configuration about default database connection

DEFINE CLASS ClassDatabaseConnection AS ClassCustom

	Username = "root"
	Password = ""
	Hostname = "127.0.0.1"
	Database = "oovfp"
	PortNumber = 3306

	Engine = "MYSQL"
	
	Handle = 0
	ConnectionString = ""
	IsOpen = .F.
	
	FUNCTION Open
		LOCAL ARRAY laMysqlError(1)
		LOCAL loError
		
		IF This.IsOpen = .T. THEN
			RETURN .T.
		ENDIF
		
		&& not displaying login dialog on error connection
		SQLSETPROP(This.Handle, 'DispLogin', 3) 
		&& only execute next line of code when query have been completely executed
		SQLSETPROP(This.Handle, 'Asynchronous', .F.)
		
		This.ConnectionString = "DRIVER=MySQL ODBC 3.51 Driver" ;
			+ ";UID=" + This.Username ;
			+ ";PWD=" + This.Password;
			+ ";SERVER=" + This.Hostname;
			+ ";DATABASE=" + This.Database ;
			+ ";PORT=" + ALLTRIM(STR(This.PortNumber))
			
		STORE SQLSTRINGCONNECT(This.ConnectionString) TO This.Handle
		
		&& check for errors
		IF This.Handle<=0 THEN
			AERROR(laMysqlError)
			IF laMysqlError(1) = 1526 THEN
				&& ODBC error
				loErrors = NEWOBJECT("ClassErrors")
				loErrors.Type = "NOTICE"
				loErrors.Description = laMysqlError(3)
				loErrors.Add()
				RETURN .F.
			ENDIF
		ENDIF
		
		This.IsOpen = .T.
		RETURN .T.	
	ENDFUNC
	
ENDDEF
