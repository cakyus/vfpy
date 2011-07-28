
DEFINE CLASS ClassFormError AS ClassForm
	
	ADD OBJECT LabelInfo AS ClassLabelTextbox
	
	FUNCTION Init
		LPARAMETERS loError
		DODEFAULT()
		
		This.Caption = loError.Type
		This.LabelInfo.Caption = loError.Description
			
		This.LogoPicture = "form-about.bmp"
		This.WindowState = 0
		This.Width = 400
		This.Height = 300
		This.AutoCenter = .T.
		
	ENDFUNC
	
	FUNCTION Activate
		DODEFAULT()
		This.MoveTop(This.LabelInfo)
		This.SizeWidth(This.LabelInfo, 100)
		This.SizeHeight(This.LabelInfo, 100)
	ENDFUNC	
ENDDEF
