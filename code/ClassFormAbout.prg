
DEFINE CLASS ClassFormAbout AS ClassForm
	
	ADD OBJECT LabelInfo AS ClassLabel
	
	FUNCTION Init
		DODEFAULT()
		LOCAL loVersion
		
		loVersion = THISFORM.Parent.GetObject("ClassVersion")
		This.Caption = loVersion.Product
		&& This.LabelInfo.AutoSize = .F.
		This.LabelInfo.Caption = 'Version : ' + loVersion.Number ;
			+ CHR(13) + CHR(10) + 'Comments : ' + loVersion.Comments ;
			+ ''
			
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
ENDDEFINE 
