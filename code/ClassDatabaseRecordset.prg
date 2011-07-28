
DEFINE CLASS ClassDatabaseRecordset AS ClassCustom

	Username = ""
	Password = ""
	
	FUNCTION Open
		LPARAMETERS lcTableName
		LOCAL loDatabaseSchema
		
		loDatabaseSchema = NEWOBJECT("ClassDatabaseSchema")
		loDatabaseSchema.Open(lcTableName)
		
	ENDFUNC
	
	FUNCTION Seek
		
	ENDFUNC
ENDDEF
