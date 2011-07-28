option explicit

dim option_build_run
dim option_build_exe
dim option_build_dll

dim option_project_name
dim option_counter

option_project_name = "oovfp"

option_build_run = false
option_build_exe = false
option_build_dll = false

echo "read command line options .."
for option_counter = 0 to wscript.arguments.count - 1
	if  wscript.arguments.item(option_counter) = "run" then
		option_build_run = true
	elseif wscript.arguments.item(option_counter) = "exe" then
		option_build_exe = true
	elseif wscript.arguments.item(option_counter) = "dll" then
		option_build_dll = true
	end if
next

dim o_project
set o_project = new project
o_project.build

echo "completed .."

class project

	dim co_fso
	dim co_vfp
	dim co_config

	dim cs_path
	dim cs_temp_path
	
	private sub class_initialize
	
		set co_fso = createobject("scripting.filesystemobject")
		set co_vfp = createobject("visualfoxpro.application")
		set co_config = new config
	end sub
	
	function build
		read_config
		clear_temp
		create_project
		build_project
		do_option
	end function
	
	function read_config
	
		cs_path = get_project_path
		cs_temp_path = get_temp_path
		
		co_config.read cs_path & "\script\build.ini"
	end function
	
	function clear_temp
		dim lo_dir
		dim lo_file
		echo "clear temporary folder"
		for each lo_dir in co_fso.getfolder(cs_path & "\temp").subfolders
			echo "del: " & lo_dir.path
			if lo_dir.Attributes and 2 then
				' not deleting hidden subfolder, eg. folder used for subversion
			else
				lo_dir.delete true
			end if
		next
		for each lo_file in co_fso.getfolder(cs_path & "\temp").files
			echo "del: " & lo_file.path
			lo_file.delete true
		next
	end function
	
	function create_project
		
		dim lo_file
		dim lo_file_main
				
		' copy all project files
		echo "add create main.prg for the project .."		
		
		set lo_file_main = co_fso.CreateTextFile(cs_temp_path & "\main.prg", true)
		' main.prg from the source code must be on the top of main.prg in the temporary project
		' otherwise the code will never be executed
		lo_file_main.Write co_fso.OpenTextFile(cs_path & "\code\main.prg").ReadAll
		
			' merge all .prg into main.prg
		for each lo_file in co_fso.GetFolder(cs_path & "\code").Files
			if lcase(right(lo_file.Name,4)) <> ".prg" then
			elseif lcase(lo_file.Name) = "main.prg" then
			elseif lo_file.Size > 0 then
				echo "add: " & lo_file.Path
				lo_file_main.Write co_fso.OpenTextFile(lo_file.Path).ReadAll
			end if
		next
		
		lo_file_main.Close
		
		obfuscation cs_temp_path & "\main.prg"
			
		
		' create project
		echo "build project: " & cs_temp_path & "\main.pjx"
		
		co_vfp.docmd "build project '" & cs_temp_path & "\" & option_project_name & ".pjx' " & _
			" from '" & cs_temp_path & "\main.prg'"
		co_vfp.docmd "modify project '" & cs_temp_path & "\" & option_project_name & ".pjx'"
		
		' add additional files into project
		echo "add more files into project .."
		for each lo_file in co_fso.GetFolder(cs_path & "\resource").Files
			co_fso.CopyFile lo_file.Path , cs_temp_path + "\" + lo_file.Name
			echo "add: " & lo_file.Path
			co_vfp.ActiveProject.Files.Add cs_temp_path + "\" + lo_file.Name
		next
		
		echo "add more files into folder .."
		for each lo_file in co_fso.GetFolder(cs_path & "\library").Files
			echo "add: " & lo_file.Path
			co_fso.CopyFile lo_file.Path , cs_temp_path + "\" + lo_file.Name
		next
		
		
		' set project info
		echo "set project build info .."
		co_vfp.ActiveProject.Debug = true
		co_vfp.ActiveProject.Encrypted = true
		
		echo "set project versions .."
		set_project_version co_vfp.ActiveProject
		
		echo "set project main file .."
		co_vfp.ActiveProject.SetMain "main.prg"
	end function
	
	function build_project
		echo "build project .."
		' mk:@MSITStore:foxhelp.chm::/html/lngbuild_method.htm
		if option_build_exe = true then
			echo "build exe: " & cs_temp_path & "\" & co_config.item("ExeFileName") & ".exe"
			co_vfp.ActiveProject.Build cs_temp_path & "\" & co_config.item("ExeFileName") & ".exe", 3, true, true
		elseif option_build_dll = true then
			echo "build dll: " & cs_temp_path & "\" & co_config.item("ExeFileName") & ".dll"
			co_vfp.ActiveProject.Build cs_temp_path & "\" & co_config.item("ExeFileName") & ".dll", 5, true, true
		end if
	end function
	
	function obfuscation(ps_path)
		' @todo remove all blank lines
		' @todo remove leading tabs and ending tabs
		' @todo remove all comment
	end function
	
	function set_project_version(po_project)
		
		po_project.VersionNumber = co_config.item("VersionNumber")
		po_project.VersionCompany = co_config.item("VersionCompany")
		po_project.VersionCopyright = co_config.item("VersionCopyright")
		po_project.VersionDescription = co_config.item("VersionDescription")
		po_project.VersionProduct = co_config.item("VersionProduct")
		po_project.VersionTrademarks = co_config.item("VersionTrademarks")
		
		if len(po_project.VersionComments) > 1 then
			po_project.VersionComments = _
				po_project.VersionComments & _
				Chr(13) & chr(10) 
		end if
 
		po_project.VersionComments = _
			po_project.VersionComments & _
			"Build ID: " & new_id()
		
	end function
	
	function new_id
		' @purpose generate unique id
		new_id = co_fso.GetTempName()
	end function
	
	function get_project_path
		get_project_path = co_fso.getfile(wscript.scriptfullname).parentfolder.parentfolder
	end function
	
	function get_temp_path
		get_temp_path = cs_path & "\temp"
	end function
	
	function do_option
	
		dim lo_file
		
		echo "check for errors .."
		
		for each lo_file in co_fso.getfolder(cs_temp_path).files
			if right(ucase(lo_file.name),4) = ".err" then
				echo ""
				echo "-- WARNING! ERROR HAVE BEEN OCCURED WHEN BUILDING PROJECT --"
				echo co_fso.opentextfile(cs_temp_path & "\main.err").readall
				exit function
			end if
		next
		
		echo "do actions specified in command line options .."
		
		if option_build_run = true then
			echo "option build run .."
			echo "DO """ & cs_temp_path & "\main.prg"""
			co_vfp.DoCmd "DO """ & cs_temp_path & "\main.prg"""
		elseif option_build_exe = true then
			echo "option build exe .."
			dim exe_path
			exe_path = cs_temp_path & "\" & co_config.item("ExeFileName") & ".exe"
			do until co_fso.FileExists(exe_path) = true
				echo "wait for " & exe_path
			loop
			echo "run executable .."
			Dim WshShell
			Set WshShell = WScript.CreateObject("WScript.Shell")
			WshShell.Run exe_path
		elseif option_build_dll = true then
			echo "option build dll .."
			dim oObject
			Set oObject = CreateObject("oovfp.Controller")
			oObject.Run
		end if
	end function
		
end class

class config

	dim co_fso
	dim co_dic
	
	sub class_initialize
		set co_fso = createobject("scripting.filesystemobject")
		set co_dic = createobject("scripting.dictionary")
	end sub
	
	function read(ps_file)
		
		dim lo_file
		dim li_pos
		dim ls_line
		
		if co_fso.FileExists(ps_file) = true then
			set lo_file = co_fso.OpenTextFile(ps_file)
			do until lo_file.AtEndOfStream = true
				ls_line = lo_file.ReadLine
				li_pos = instr(ls_line, "=")
				co_dic.add mid(ls_line, 1, li_pos -1), mid(ls_line, li_pos + 1)
			loop
		end if
	end function
	
	function item(ps_config)
		if co_dic.exists(ps_config) then
			item = co_dic.item(ps_config)
		else
			item = ""
		end if
	end function
end class


function echo(pc_text)
	wscript.echo pc_text
end function
