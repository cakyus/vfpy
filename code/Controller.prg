
DEFINE CLASS Controller AS Custom OLEPUBLIC

	DebugMode = .T.
	StartMode = 0
	Path = "" && executable folder path
	FilePath = "" && executable file path
		
	ADD OBJECT FormCollection AS ClassCollection
	
	FUNCTION Init
		DODEFAULT()
		
		SET DELETED ON
		SET EXACT ON
		SET SAFETY OFF

		IF INLIST(This.Application.StartMode,0 ,1) THEN
			&& enable debug on interactive mode
			SET DEBUG ON
			DEBUG
			SET DEBUGOUT TO "C:\DEBUG.TXT"
			SET EVENTTRACKING ON
			SET COVERAGE TO "C:\COVERAGE.TXT"
		ENDIF
		
	ENDFUNC
	
	FUNCTION Run
		LOCAL loExplorerForm
		_SCREEN.AddObject("Singleton", "ClassSingleton")
		loExplorerForm = NEWOBJECT("ClassExplorerForm")
		loExplorerForm.Show()
		READ EVENTS
	ENDFUNC
	
	FUNCTION GetObject
		LPARAMETERS lcClassName
		LOCAL lnCount, loObject
		
		&& check for existing object
		FOR lnCount = 1 TO This.ControlCount
			IF UPPER(This.Controls(lnCount).Name) = UPPER(lcClassName) THEN
				RETURN This.Controls(lnCount)
			ENDIF
		ENDFOR
		
		lcObjectName = This.NewId()
		This.AddObject(lcObjectName, lcClassName)
		
		&& sigleton class is automatically change the uniq name into lcClassName
		FOR lnCount = 1 TO This.ControlCount
			IF UPPER(This.Controls(lnCount).Name) = UPPER(lcClassName) THEN
				RETURN This.Controls(lnCount)
			ENDIF
		ENDFOR
		
		RETURN This. &lcObjectName
	ENDFUNC
	
	FUNCTION NewId
		RETURN SYS(2015)
	ENDFUNC	
	
	FUNCTION Quit
		RELEASE ALL
		CLEAR EVENTS
		CANCEL
	ENDFUNC
	
	FUNCTION GetForm
		LPARAMETERS lcClassFormName, leInit1
		LOCAL lcObjectName
		
		lcObjectName = This.NewId()
		
		IF VARTYPE(leInit1) = 'L' THEN
			This.AddObject(lcObjectName, lcClassFormName)
		ELSE
			This.AddObject(lcObjectName, lcClassFormName, leInit1)
		ENDIF
		
		This. &lcObjectName .Show()
		&& This.FormCollection.Add(lcObjectName, NEWOBJECT(lcClassFormName))
		&& This.FormCollection.Item(lcObjectName).Show()
	ENDFUNC	
ENDDEF

