
DEFINE CLASS ClassCrypto AS ClassCustom

	Engine = ""
	
	FUNCTION Encode
		LPARAMETERS lcText
		LOCAL loEngine
		
		DO CASE
		CASE This.Engine = "MD5"
			loEngine = NEWOBJECT("ClassCryptoMd5")
			RETURN loEngine.Encode(lcText)
		OTHERWISE
			MESSAGEBOX("encoding not supported for engine '" + This.Engine + "'")
		ENDCASE
		
		RETURN ""
	ENDFUNC
		
	FUNCTION Decode
		LPARAMETERS lcText
		LOCAL loEngine
		
		DO CASE
		OTHERWISE
			MESSAGEBOX("decoding not supported for engine '" + This.Engine + "'")
		ENDCASE
		
		RETURN ""
	ENDFUNC
ENDDEF
