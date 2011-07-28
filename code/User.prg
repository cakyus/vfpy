
DEFINE CLASS ClassUser AS ClassCustom

	Username = ''
	Password = ''
	
	FUNCTION Login
	
		LOCAL loRecordset, loCrypto
		
		loCrypto = NEWOBJECT("ClassCrypto")
		loCrypto.Engine = "MD5"
		
		loRecordset = NEWOBJECT("ClassDatabaseRecordset")
		
		IF loRecordset.Open("Users") = .F. THEN
			RETURN .F.
		ENDIF
		
		loRecordset.Username = This.Username
		loRecordset.Password = loCrypto.Encode(This.Password)
		
		IF loRecordset.Seek() = .F. THEN
			MESSAGEBOX("invalid username or password")
			RETURN .F.
		ENDIF
		
		RETURN .T.
	ENDFUNC
	
	FUNCTION Logout
		This.Username = ""
		This.Password = ""
		RETURN .T.
	ENDFUNC
ENDDEF

