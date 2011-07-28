
DEFINE CLASS ClassMenu AS ClassCustom

	FUNCTION Init
		This.AddObject("Menus", "ClassCollection")
	ENDFUNC

	FUNCTION Show
	
		DEFINE MENU (This.Name) IN (This.Parent.Name) BAR
		
		FOR EACH loMenu IN This.Menus.Items
			IF loMenu.IsRoot = .T. THEN
				DEFINE PAD (loMenu.MenuName) OF (This.Name) PROMPT loMenu.MenuLabel
				ON PAD (loMenu.MenuName) OF (This.Name) ACTIVATE POPUP (loMenu.MenuName)
				DEFINE POPUP (loMenu.MenuName)
				This.CreateMenuItem(loMenu.MenuName)
			ENDIF
		ENDFOR		
		
		ACTIVATE MENU (This.Name) NOWAIT	
	ENDFUNC
	
	FUNCTION Destroy
		DODEFAULT()
		RELEASE MENUS (This.Name)
	ENDFUNC
	
	FUNCTION CreateMenuItem
		LPARAMETERS lcMenuParentName
		LOCAL lnCount
		
		lnCount = 0
		
		FOR EACH loMenu IN This.Menus.Items
			IF loMenu.MenuParentName = lcMenuParentName THEN
				lnCount = lnCount + 1
				IF loMenu.IsBar = .T. THEN
					DEFINE BAR (lnCount) OF (lcMenuParentName) PROMPT "\-"
				ELSE
					DEFINE BAR (lnCount) OF (lcMenuParentName) PROMPT loMenu.MenuLabel
					lcCommand = "_SCREEN.ActiveForm." + This.Name + ".OnClick('" + loMenu.MenuName +  "')"
					ON SELECTION BAR (lnCount) OF (lcMenuParentName) &lcCommand
				ENDIF
			ENDIF
		ENDFOR		
	ENDFUNC
	
	FUNCTION AddMenu
		LPARAMETERS lcMenuParentName, lcMenuName, lcMenuLabel
		LOCAL loMenuItem
		
		loMenuItem = NEWOBJECT("ClassMenuItem")
		
		loMenuItem.MenuName = lcMenuName
		
		IF EMPTY(lcMenuParentName) THEN
			loMenuItem.IsRoot = .T.
		ELSE
			loMenuItem.MenuParentName = lcMenuParentName
		ENDIF
		
		IF EMPTY(lcMenuLabel) THEN
			loMenuItem.IsBar = .T.
		ELSE
			loMenuItem.MenuLabel = lcMenuLabel
		ENDIF
		
		This.Menus.Add(lcMenuName, loMenuItem)
	ENDFUNC
	
	FUNCTION OnClick
		LPARAMETERS lcMenuName
		LOCAL lbFound, lnCount, laMethods
		DIMENSION laMethods[1]
		
		lbFound = .F.
		FOR lnCount = 1 TO AMEMBERS(laMethods,This,1)    && Creates an array
			IF UPPER(lcMenuName) = UPPER(laMethods(lnCount)) THEN
				lbFound = .T.
			ENDIF
		ENDFOR
		
		IF lbFound = .T. THEN
			This. &lcMenuName()
		ELSE
			MESSAGEBOX('No command assigned for "' + lcMenuName + '"')
		ENDIF
	ENDFUNC
	
ENDDEF
