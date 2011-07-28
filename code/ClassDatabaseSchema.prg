
DEFINE CLASS ClassDatabaseSchema AS ClassCustom
	
	FUNCTION Open
		LPARAMETERS lcDatabaseObjectName
		LOCAL loDatabase
		loDatabase = NEWOBJECT("ClassDatabase")
	ENDFUNC
ENDDEF
