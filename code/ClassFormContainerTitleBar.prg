
DEFINE CLASS ClassFormContainerTitleBar AS ClassContainer

	&& BackStyle = 0
	BorderWidth = 0

	ADD OBJECT LabelCaption AS ClassLabel
	ADD OBJECT ImageClose AS ClassImage
	ADD OBJECT ImageLogo AS ClassImage
	
	FUNCTION Init
	
		DODEFAULT()
		
		LOCAL loTheme
		
		loTheme = NEWOBJECT("ClassTheme")
		
		This.LabelCaption.FontName = loTheme.FontName
		This.LabelCaption.FontSize = loTheme.FontSize + 10
		This.LabelCaption.FontBold = .T.
		
		This.BackColor = 16777215
		
		This.ImageLogo.BackStyle = 0
		This.ImageLogo.BorderStyle = 0
		This.ImageLogo.Height = 0
		This.ImageLogo.Width = 0
		
		This.Height = THISFORM.FormMarginTop - 10
		This.LabelCaption.Left = THISFORM.FormMarginLeft
		
		This.ImageClose.Picture = 'button-close.bmp'
	ENDFUNC
	
	FUNCTION ImageClose.Click
		DODEFAULT()
		THISFORM.Release()
	ENDFUNC
	
	FUNCTION ImageLogo.Picture_Assign
		LPARAMETERS leValue
		LOCAL lnImageLogoMargin
		
		This.Picture = leValue
		
		lnImageLogoMargin = (This.Parent.Height - This.Height) / 2
		
		This.Top = lnImageLogoMargin
		This.Left = lnImageLogoMargin
		
		This.Parent.LabelCaption.Left = This.Width + ( 2 * lnImageLogoMargin)
	ENDFUNC
ENDDEF
