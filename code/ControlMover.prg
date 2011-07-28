
DEFINE CLASS ClassControlMover AS ClassCustom
	
	coContainer = .NULL.
	ControlSpacing = 10
	MarginTop = 0
	MarginLeft = 0
	MarginRight = 0
	MarginBottom = 0
	
	FUNCTION SetContainer
		LPARAMETERS loContainer
		This.coContainer = loContainer
	ENDFUNC
	
	FUNCTION ContainerBottomLeft
		LPARAMETERS loObject
		loObject.Left = This.MarginLeft
		loObject.Top = This.coContainer.Height - loObject.Height - This.MarginTop - This.MarginBottom
	ENDFUNC
	
	FUNCTION MoveRight
		LPARAMETERS loObjectRef, loObject
		loObject.Left = loObjectRef.Left + loObjectRef.Width + This.ControlSpacing
	ENDFUNC
	
	FUNCTION SameTop
		LPARAMETERS loObjectRef, loObject
		loObject.Top = loObjectRef.Top
	ENDFUNC
	
	FUNCTION FillHeight
		LPARAMETERS loObjectRef, loObject
		IF loObjectRef.Top > loObject.Top THEN
			loObject.Height = loObjectRef.Top - loObject.Top - This.ControlSpacing
		ELSE
			&& @todo
		ENDIF
	ENDFUNC
ENDDEF

