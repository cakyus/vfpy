
DEFINE CLASS ClassGridNavigator AS ClassContainer

	ADD OBJECT grdData AS ClassGrid
	ADD OBJECT cmdFirst AS ClassCommandButton
	ADD OBJECT cmdNext AS ClassCommandButton
	ADD OBJECT cmdPrevious AS ClassCommandButton
	ADD OBJECT cmdLast AS ClassCommandButton
	
	curCursor = .NULL.
	
	FUNCTION Init
		DODEFAULT()
		This.BackStyle = 0
		This.BorderWidth = 0
		This.cmdFirst.Caption = "First"
		This.cmdNext.Caption = "Next"
		This.cmdPrevious.Caption = "Previous"
		This.cmdLast.Caption = "Last"
	ENDFUNC
	
	FUNCTION GetCursor
		LPARAMETERS lcClassCursorName
		This.curCursor = NEWOBJECT(lcClassCursorName)
		This.curCursor.Page.GetCursor()
		This.grdData.RecordSource = This.curCursor.Page.CursorName
	ENDFUNC
	
	FUNCTION Resize
		DODEFAULT()
		
		LOCAL loControlMover
		loControlMover = NEWOBJECT("ClassControlMover")
		loControlMover.SetContainer(This)
		
		This.grdData.Width = This.Width
		
		loControlMover.ContainerBottomLeft(This.cmdFirst)
		loControlMover.MoveRight(This.cmdFirst, This.cmdPrevious)
		loControlMover.MoveRight(This.cmdPrevious, This.cmdNext)
		loControlMover.MoveRight(This.cmdNext, This.cmdLast)
		loControlMover.SameTop(This.cmdFirst, This.cmdPrevious)
		loControlMover.SameTop(This.cmdPrevious, This.cmdNext)
		loControlMover.SameTop(This.cmdNext, This.cmdLast)
		loControlMover.FillHeight(This.cmdFirst, This.grdData)
	ENDFUNC
	
	FUNCTION cmdFirst.Click
		DODEFAULT()
		This.Parent.curCursor.Page.MoveFirst()
		This.Parent.grdData.Refresh()
	ENDFUNC

	FUNCTION cmdPrevious.Click
		DODEFAULT()
		This.Parent.curCursor.Page.MovePrevious()
		This.Parent.grdData.Refresh()
	ENDFUNC

	FUNCTION cmdNext.Click
		DODEFAULT()
		This.Parent.curCursor.Page.MoveNext()
		This.Parent.grdData.Refresh()
	ENDFUNC

	FUNCTION cmdLast.Click
		DODEFAULT()
		This.Parent.curCursor.Page.MoveLast()
		This.Parent.grdData.Refresh()
	ENDFUNC

ENDDEF

