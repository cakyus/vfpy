
DEFINE CLASS ClassVersion AS ClassCustom

	Number = "1.0.0"
	Company = "VersionCompany"
	Copyright = "VersionCopyright"
	Description = "VersionDescription"
	Product = "VersionProduct"
	Trademarks = "VersionTrademarks"
	Comments = "VersionComments"

	FUNCTION Init
		DODEFAULT()
		
		&& @note
		&& ----
		&& ? SYS(16)
		&& PROCEDURE CLASSVERSION.INIT D:\DOCUMENTS\PROJECTS\VISUALFOXPRO\OOVFP\TEMP\MAIN.FXP
		&& ----
		&& the MAIN.FXP can be replaced by MAIN.EXE or MAIN.DLL
		&& it depends on how the project was compiled
		
		LOCAL lcApplicationPath
		LOCAL lnPos, lcText
		LOCAL ARRAY laVersion(1)
		
		lnPos = AT(" ", SYS(16), 2)
		
		IF lnPos > 0 THEN
		
			lcApplicationPath = SUBSTR(SYS(16), lnPos + 1)
			
			IF INLIST(UPPER(RIGHT(lcApplicationPath, 4)), ".EXE", ".DLL") THEN
			
				AGETFILEVERSION(laVersion, lcApplicationPath)
				
				IF ALEN(laVersion) = 15 THEN
					This.Number = laVersion(4)
					This.Company = laVersion(2)
					This.Copyright = laVersion(6)
					This.Description = laVersion(3)
					This.Product = laVersion(10)
					This.Trademarks = laVersion(7)
					This.Comments = laVersion(1)
				ENDIF
			ENDIF
		ENDIF
		
		&& MESSAGEBOX(ALLTRIM(STR(This.Application.StartMode)))
		&& MESSAGEBOX(This.Application.FullName)
		&& MESSAGEBOX(SYS(16))
		
		&& IF This.Application.StartMode = .F. THEN
		
			&& AGETFILEVERSION(laVersion, This.Parent.FilePath)
			
			&& This.Number = laVersion(4)
			&& This.Company = laVersion(2)
			&& This.Copyright = laVersion(6)
			&& This.Description = laVersion(3)
			&& This.Product = laVersion(10)
			&& This.Trademarks = laVersion(7)
			&& This.Comments = laVersion(1)
		&& ELSE
		&& ENDIF	
	ENDFUNC
ENDDEF
