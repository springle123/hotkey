#SingleInstance force 

#include  <message> 		;;包含Messge库

#include  <ScreenCapture>   ;;包含ScreenCapture.ahk

SetBatchlines -1              ;;全速运行

SetTitleMatchMode,RegEx       ;;窗口匹配方式为正则匹配

sendmode input                ;;send模式为input

;ComObjError(false)			  ;;关闭Com错误信息

CoordMode, Mouse, Screen      ;;鼠标坐标轴为屏幕

CoordMode, ToolTip, Screen    ;;工具条坐标轴为屏幕

ActiveWinHwnd :=              ;;激活窗口ID

Xdelta := 50				  ;;横向窗口移动量

Ydelta := 30				  ;;纵向窗口移动量

CloseState:="off"              ;;开启自动关闭CMD窗口

hotkey, MButton, off          ;;初始设置中键快捷键为关闭

hotkey, Space, off			  ;;初始设置Space快捷键为关闭	

PanelHwnd := ""				  ;;初始化翻译界面句柄

GithubFolder := "F:\GitCode"  ;;Github目录

Comment :=					  ;;初始化Comment

ZoomState=False

if(is_snadial_run())
	dial_hotkey_off()



; loop	
	; {
		; CloseCMD()
		; sleep, 3000
	; }
	
GroupAdd, Explorer, ahk_class Progman
GroupAdd, Explorer, ahk_class WorkerW
GroupAdd, Explorer, ahk_class CabinetWClass
			

return

;HotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkey

pause::
	if( CloseState = "on")
		CloseState := "off"
	else
	{	
		CloseState := "on"
	}
	return

#s::	;;suspend all hotkey
	suspend,permit
	suspend()
	return

#c::
	run, %windir%\system32\calc.exe
	return
	
#ESC::
	run_and_hide("TOTALCMD.EXE", "D:\totalcmd\TOTALCMD.EXE", "ahk_class TTOTAL_CMD")
	return
	
#f::	;;launch everything.exe
	;RunProgram("Everything.exe", "D:\Small software\Everything\Everything.exe")
	run_and_hide("Everything.exe", "D:\Small software\Everything\Everything.exe", "ahk_class EVERYTHING")
	return
#g::    ;;comit script to github, see lable
	git_commit()
	return
	
; #g::	;;get active window ID
	; ActiveWinHwnd := get_active_win()
	; return

#h::	;;hide tray window
	hide_window("ahk_class Shell_TrayWnd")
	return
	
; #h::	;;send html frame
	; send_html_frame()
	; return
	
#j::   ;;run ImageJ
	run, D:\Program Files\ImageJ\ImageJ.exe
	return
	
#t::	;;set active window on top
	set_win_ontop()
	return

#up::	;;miximize active window
	MaximizeWin()
	return
	
#w::	;;launch wifi
	run,%comspec% /c Wifi_Launcher.cmd
	return
#z::
	window()
	return
	
^left::     ;;move window left
	move_window("left", -Xdelta)
	return

^right::	;;move window right
	move_window("right", Xdelta)
	return

^Up::	;;move window up
	move_window("up", -Ydelta)
	return

^Down::   ;;move window down
	move_window("down", Ydelta)
	return

;;翻译快捷键//////////////////////	
;^t::	
	;Translate_to_clipboard("no")
	;return

#IfWinNotActive	  ahk_class TTOTAL_CMD
^d::	;;translate selected sentences
	translate_to_clipboard()
	return
#IfWinNotActive

#IfWinNotActive ahk_class Warcraft III
#IfWinNotActive ahk_class Notepad++
^q::
	old_clipboard := clipboard
	copy_to_clip()
	file := "F:\Study\new_word\" . A_YYYY . A_MM . A_DD . ".txt"
	fileappend, %clipboard%`n, %file%
	traytip, , 单词%clipboard%已经加入单词本。。。
	clipboard := old_clipboard
	return
#IfWinNotActive
#IfWinNotActive

MButton::
Space::		;;exit translate panel
	Gui, Panel:	destroy
	IfWinNotExist , ahk_id%PanelHwnd%
	{
		hotkey, MButton, off
		hotkey, Space, off
	}
	return
;;翻译快捷键//////////////////////	
	
!F3::
	run, F:\literature	
	return
	

	
~Tab & f::    ;;search baidu engine with clipboard as keyword
	search_baidu()
	return	
	


^#up::	;;set active window size to top half screen
	set_win_pos(0, 0, A_ScreenWidth, A_ScreenHeight/2)
	return

^#down::	;;set active window size to bottom half screen
	set_win_pos(0, A_ScreenHeight/2, A_ScreenWidth, A_ScreenHeight/2)
	return

^!a::	;;dial bras a
	run, snadial.ahk -v -a
	dial_hotkey_off()
	return	
	
	
^!b::	;;dial bras b
	run, snadial.ahk -v -b
	dial_hotkey_off()
	return
	
^+a::
	run, snadial.ahk -s -a
	dial_hotkey_off()
	return

^+b::
	run, snadial.ahk -s -b
	dial_hotkey_off()
	return

^!n::   
	run notepad
	return
	
^!o::	;;run path of active program
	run_program_path()
	return
	
^!w::	;;login seu-wlan
	login_seu_wlan()
	return

;;截图快捷键/////////////////	

F8::
	DetectHiddenWindows On  ; 才可以检测到脚本的隐藏主窗口.
	SetTitleMatchMode 2  ; 避免为下面的文件指定完整的路径.
	IfWinNotExist Magnifier.ahk - AutoHotkey 
		run, C:\Users\lcq\Desktop\resource\Magnifier.ahk
	else
		WinClose Magnifier.ahk - AutoHotkey
	DetectHiddenWindows Off
	return
	
^!LButton::
	CaptureGUI()
	DetectHiddenWindows On  ; 才可以检测到脚本的隐藏主窗口.
	SetTitleMatchMode 2  ; 避免为下面的文件指定完整的路径.
	WinClose Magnifier.ahk - AutoHotkey 
	DetectHiddenWindows Off
	Return
	
^!MButton::
	FixedCapture()
return
	
!PrintScreen::
	CaptureClient(2)
	return
^!PrintScreen::
	CaptureClient(1)
	return
	
	
$^r::
DetectHiddenWindows, on
IfWinExist, ahk_class AutoHotkeyGUI, >>>>截取屏幕
{
	Gui, captureRect:  show
	Gui, captureRect2:  show
	winactivate, ahk_class AutoHotkeyGUI, >>>>截取屏幕
}
else
	send, ^r
DetectHiddenWindows, off
return	

;;放大窗口快捷键///////////////////


;;放大窗口快捷键///////////////////	
	
#ifwinactive ahk_class AutoHotkeyGUI, >>>>截取屏幕

enter::
	CaptureImage()
	return
	
alt & enter::
	CaptureImage(1)
	return
	
ESC::
	Gui, captureRect:  destroy
	Gui, captureRect2:  destroy
	return
	
left::
	move_window("left", -1) 
	return

right::
	move_window("left", 1)
	return
	
up::
	move_window("up", -1) 
	return
	
down::
	move_window("down", 1)
	return
#ifwinactive
;;截图快捷键//////////////


F7::^+n
return


#IfWinActive ahk_group Explorer
F4::
	OpenWithNotepadPP()
	return
	
#IfWinActive	

	
LWin & F1:: 	;;launch youdao dictionary， window hidden
	hide_window("ahk_class YodaoMainWndClass")
	return

LControl & F1:: 	;;launch youdao dictionary
	RunProgram("YodaoDict.exe", "C:\Users\lcq\AppData\Local\Youdao\Dict\Application\YodaoDict.exe")
	return

SHIFT & mButton::	;;get mouse coordinate
	get_mouse_cood()
	return


#IfWinActive .*\.(ahk|AHK) - Notepad++

F1::
	open_helpfile("ahk")
	return
	
#IfWinActive


#IfWinActive .*\.(py|PY|pyw|PYW) - Notepad++
F1::
	open_helpfile("py")
	return

#IfWinActive



#IfWinActive .*\.(py|ahk|AHK|PY) - Notepad++	
	
$~=:: 
	python_equal()
	return

$~>:: 
	python_hotkey()
	return

$~<::
	python_lt()
	return

$~+::
	python_hotkey()
	return

$~-:: 
	python_hotkey()
	return

$~!::
	python_unequal()
	return

$,::
	send,,%a_space%
	return


#IfWinActive


#ifwinactive ahk_class AcrobatSDIWindow

+c::
	remove_endline()
	return	

+s::
click_pic("C:\Users\lcq\Desktop\resource\pdfpic\select.bmp")
ifwinexist, ahk_class AVL_AVFloating
	winhide, ahk_class AVL_AVFloating
return

+h::
click_pic("C:\Users\lcq\Desktop\resource\pdfpic\highlight.bmp")
return

+a::
click_pic("C:\Users\lcq\Desktop\resource\pdfpic\addtext.bmp")
return

+u::
click_pic("C:\Users\lcq\Desktop\resource\pdfpic\underline.bmp")


return

#ifwinactive

	
#IfWinActive 按键精灵

F5::
Dubug_AnJian()
return

^n::
create_new()
return

^+s::
save_exit()
return

^m::
modify_script()
return

#ifwinactive


#IfWinActive ahk_class Warcraft III


q::Numpad7

space::Numpad8

LWin::return

$s::
	send ,s
	sleep, 90	
	return
	
#IfWinActive




;//////HotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkey

;LabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabel
; CommentPanelGuiClose:
; CommentPanelButtonOK:
	; submit_comment()
	; return
	
CommentPanelGuiClose:
CommentPanelButtonOK:
	ComenGui.submit()
	return
;/////LabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabelLabel




;HotStringHotStringHotStringHotStringHotStringHotStringHotStringHotStringHotStringHot

#IfWinNotActive 按键精灵
:*?:<>::
send <>{left}
return

:*?:""::
send ""{left}
return

:*?:''::
send ''{left}
return

:*:<?::
send <?php?>{left 2}{enter 2}{up}{tab}
return

:*?:()::
send (){left}
return

:*?:[]::
send []{left}
return

:*?:raw_input::raw_input("> ")
return

#if
;/////////HotStringHotStringHotStringHotStringHotStringHotStringHotStringHotStringHot

;FunctionFunctionFunctionFunctionFunctionFunctionFunctionFunctionFunctionFunctionFunction

;;base function////////////


class CommentGUI
{
	Content := 
    __New(title := "Enter your comment", prompts := "Enter your comment")
    {
		global Content
		this.title := title
		this.prompts := prompts
        Gui, CommentPanel: New  
		Gui, CommentPanel: Add, Text,, %prompts%
		Gui, CommentPanel: Add, Edit, vContent ym  ; ym 选项开始一个新的控件列.
		Gui, CommentPanel: Add, Button, default ym , OK ; ButtonOK (如果存在的话) 会在此按钮被按下时运行.
		Gui, CommentPanel: Show,, %title%
    }

	waitfor_input()
	{
		
		while(!(this.Content))
			sleep, 100
	}
	
	submit()
	{
		global Content
		Gui, CommentPanel: Submit  ; 保存用户的输入到每个控件的关联变量中.
		this.Content := Content
		if(!Content)
		{
			traytip, , Content不能为空, 请重新输入。
			Gui, CommentPanel: Show,, % this.prompts
			return
		}
		Gui, CommentPanel: destroy
		return
	}
	
}

suspend()
{

	if A_IsSuspended
		suspend,off
	else
		suspend,on
		
	return
}

copy_to_clip()
{
	clipboard = ; 清空剪贴板
	Send, ^c
	ClipWait, 300
	if ErrorLevel
	{
		MsgBox, The attempt to copy text onto the clipboard failed.
		return
	}

}

StrPutVar(string, ByRef var, encoding)
{
	; 确定容量.
	VarSetCapacity( var, StrPut(string, encoding)
		; StrPut 返回字符数, 但 VarSetCapacity 需要字节数.初始化为0
		* ((encoding="utf-16"||encoding="cp1200") ? 2 : 1), 0)
	; 复制或转换字符串.
	return StrPut(string, &var, encoding)
}


StdoutToVar_CreateProcess(sCmd, bStream="", sDir="", sInput="")
{

bStream=   ; not implemented



DllCall("CreatePipe","Ptr*",hStdInRd,"Ptr*",hStdInWr,"Uint",0,"Uint",0)

DllCall("CreatePipe","Ptr*",hStdOutRd,"Ptr*",hStdOutWr,"Uint",0,"Uint",0)

DllCall("SetHandleInformation","Ptr",hStdInRd,"Uint",1,"Uint",1)

DllCall("SetHandleInformation","Ptr",hStdOutWr,"Uint",1,"Uint",1)

if A_PtrSize=4

	{

	VarSetCapacity(pi, 16, 0)

	sisize:=VarSetCapacity(si,68,0)

	NumPut(sisize,    si,  0, "UInt")

	NumPut(0x100,     si, 44, "UInt")

	NumPut(hStdInRd , si, 56, "Ptr")

	NumPut(hStdOutWr, si, 60, "Ptr")

	NumPut(hStdOutWr, si, 64, "Ptr")

	}

else if A_PtrSize=8

	{

	VarSetCapacity(pi, 24, 0)

	sisize:=VarSetCapacity(si,96,0)

	NumPut(sisize,    si,  0, "UInt")

	NumPut(0x100,     si, 60, "UInt")

	NumPut(hStdInRd , si, 80, "Ptr")

	NumPut(hStdOutWr, si, 88, "Ptr")

	NumPut(hStdOutWr, si, 96, "Ptr")

	}



DllCall("CreateProcess", "Uint", 0, "Ptr", &sCmd, "Uint", 0, "Uint", 0, "Int", True, "Uint", 0x08000000, "Uint", 0, "Ptr", sDir ? &sDir : 0, "Ptr", &si, "Ptr", &pi)

DllCall("CloseHandle","Ptr",NumGet(pi,0))

DllCall("CloseHandle","Ptr",NumGet(pi,A_PtrSize))

DllCall("CloseHandle","Ptr",hStdOutWr)

DllCall("CloseHandle","Ptr",hStdInRd)



If   sInput <>

	FileOpen(hStdInWr, "h", "UTF-8").Write(sInput)



DllCall("CloseHandle","Ptr",hStdInWr)



VarSetCapacity(sTemp,4095)

nSize:=0

loop

	{

	result:=DllCall("Kernel32.dll\ReadFile", "Uint", hStdOutRd,  "Ptr", &sTemp, "Uint", 4095,"UintP", nSize,"Uint", 0)

	if (result="0")

		break

	else

		sOutput:= sOutput . StrGet(&sTemp,nSize,"cp936")

	}



DllCall("CloseHandle","Ptr",hStdOutRd)

Return,sOutput

}


UrlEncode(String,CharacterSet="cp0")
{
OldFormat := A_FormatInteger
SetFormat, Integer, H
Loop, Parse, String
	{
	If A_LoopField is Alnum
		{
		Out .= A_LoopField
		Continue
		}

	If A_LoopField is Space
		{
		Out .= "%20"
		Continue
		}


	If         (CharacterSet="cp0"||CharacterSet="gb2312"||CharacterSet="gbk")
		Out .= getChr_GBK_Code(A_LoopField)
	Else
		Out .= getChr_UTF8_Code(A_LoopField)

	}
SetFormat, Integer, %OldFormat%
Return Out
}


getChr_UTF8_Code(UTF16)
{
	SetFormat, Integer, H
	StrPutVar(UTF16,UTF8,"UTF-8")
	ChrUTF8Code := NumGet(UTF8, 0, "UInt")
	str := strget(&UTF8, 2, "gbk")
	StringMid,ch3,ChrUTF8Code,3,2
	StringMid,ch2,ChrUTF8Code,5,2
	StringMid,ch1,ChrUTF8Code,7,2
	ChrUTF8Code := SubStr(ChrUTF8Code, 3 )
	
	If(StrLen( ChrUTF8Code)=6)
	{
		ChrUTF8Code:="%" . ch1 . "%" . ch2 . "%" . ch3
	}
	Else
		ChrUTF8Code:="%" . ChrUTF8Code

	Return ChrUTF8Code
}


getChr_GBK_Code(UTF16)
{
  SetFormat, Integer, H
  StrPutVar(UTF16, var, "cp0")
  ChrGBKCode := NumGet(var, 0, "UInt")
  StringMid,ch2,ChrGBKCode,3,2
  StringMid,ch1,ChrGBKCode,5,2
  ChrGBKCode := SubStr(ChrGBKCode, 3 )  
   If  (StrLen( ChrGBKCode)=4)
        {
        ChrGBKCode:= "%" . ch1 . "%" . ch2
    }
 If  (StrLen( ChrGBKCode)=2)
        {
        ChrGBKCode:= "%" . ch2
    }

  Return ChrGBKCode
}

dial_hotkey_off()
{
	hotkey, ^!b, off
	hotkey, ^!a, off
	hotkey, ^+a, off
	hotkey, ^+b, off
}

;;base function////////////



;;start run function////////////

CloseCMD()
{
	global CloseState
	loop
	{
		if(CloseState="off")
			return
		winget, cnt, count, ahk_class ConsoleWindowClass
		if (cnt >= 1)
		{
			loop %cnt%
			{
				winclose, ahk_class ConsoleWindowClass
			}
		}
		sleep, 3000
	}
}

is_snadial_run()
{
	psvc := ComObjGet("winmgmts:{impersonationLevel=impersonate}!" . "\\.\root\cimv2")
	penm := psvc.ExecQuery("SELECT * FROM Win32_Process WHERE Name='Autohotkey.exe'")._NewEnum 
	While penm[pobj]
	{
			PID := pobj.ProcessId           ; 获取进程PID
			CMDLine := pobj.CommandLine    ; 获取进程命令行
			ifinstring, CMDLine, Snadial.ahk
			{
				return true
			}
	}
	return false
}

;;start run function////////////



;;window function////////////

get_active_win()
{
	winget,ActiveWinId,id,A
	wingettitle,title,ahk_id %ActiveWinId%
	;traytip,,得到%title%的句柄。。。
	return ActiveWinId
}

window()
{
	global WM_SYSCOMMAND
	winget,Cid,id,A
	winmove, ahk_id %Cid%, , A_ScreenWidth/2-400, A_ScreenHeight/2-300, 800, 600
}

hide_window(ahkclass)   ;;hide normal window include Shell_TrayWnd and youdao
{
	IfWinExist,%ahkclass%
	{
		
		if(ahkclass = "ahk_class Shell_TrayWnd")
			WinHide,开始 ahk_class Button
		if(ahkclass="ahk_class YodaoMainWndClass")
			winclose, %ahkclass%
		else
			WinHide,%ahkclass%
	}
	Else
	{
		if(ahkclass="ahk_class YodaoMainWndClass")
		{
			process, exist, YodaoDict.exe
			hWnd := errorlevel
			if(hWnd=0)
			{
				RunProgram("YodaoDict.exe", "C:\Users\lcq\AppData\Local\Youdao\Dict\Application\YodaoDict.exe", false)
				return
			}
		}
		WinShow,%ahkclass%
		if(ahkclass = "ahk_class Shell_TrayWnd")
			WinShow,开始 ahk_class Button
		else
		{
			winwait, %ahkclass%
			winactivate, %ahkclass%
		}
	}
}

set_win_ontop()
{
	winget,Cid,id,A
	
	winset,alwaysontop,,ahk_id %Cid%
	
	wingettitle,title,ahk_id %Cid%
	
	WinGet, ExStyle, ExStyle,%title%
	
	if (ExStyle & 0x8)
		traytip,,正在设置 %title% 窗口置顶。。。
	else
		traytip,,正在取消 %title% 窗口置顶。。。
	return
}

move_window(direction, delta)
{
	winget,Cid,id,A
	WinGetPos,wx,wy,ww,wh,ahk_id %Cid%
	
	if (direction = "left" || direction = "right")
	{
		wx += delta
		winMove,ahk_id %Cid%,,%wx%
	}
	else
	{
		wy += delta
		winMove,ahk_id %Cid%,,%wx%,%wy%
	}
	
	loop
	{
		if (a_index=1)
			sleep 200            ;;轻微移动一次
			
		KeyIsDown := GetKeyState(direction, "P")
		
		if (KeyIsDown)
			{
				WinGetPos,wx,wy,ww,wh,ahk_id %Cid%
				
				if (direction = "left" || direction = "right")
				{
					wx += delta
					winMove,ahk_id %Cid%,,%wx%
				}
				else
				{
					wy += delta
					winMove,ahk_id %Cid%,,%wx%,%wy%
				}
					
				winMove,ahk_id %Cid%,,%wx%
				
			}
		else
			break
	}
	return
}

set_win_pos(left, top, width, height)
{
	global WM_SYSCOMMAND
	winget,Cid,id,A
	;winmove, ahk_id %Cid%, , left, top, width, height
	DllCall("MoveWindow", "UInt", Cid, "Int", left, "Int", top, "Int", width, "Int", height, "Int", 1)
	;sendmessage, WM_SYSCOMMAND, 0x0000F122, 0x00120250, , ahk_id %Cid%
}

MaximizeWin()
{
	global WM_SYSCOMMAND
 	winget,Cid,id,A
	sendmessage, WM_SYSCOMMAND, 0x0000F122, 0x00120250, , ahk_id %Cid%
	sleep, 50
	sendmessage, WM_SYSCOMMAND, 0x0000F030, 0x0006026A, , ahk_id %Cid%
;	WinMinimize, ahk_id %Cid%
	;WinMaximize, ahk_id %Cid% 
	return
}

;;window function////////////



;;translate function////////////



is_chinese(str)
{
	RegExMatch(str, "(*UCP)[^\d\W]+", str)
	StringLeft, str, str, 1
	StrPutVar(str, var, "utf-8")
	number := NumGet(var, 0, "UInt")
	if(number > 256)
		return true
	else
		return false	
}

preproccess_string(byref str)
{
	
	if(RegExMatch(str, "(-\r\n\d{2,3})|(-\s\d{2,3}\r\n)"))
	{
		str := RegExReplace(str, "\s\d{2,3}(?=\r\n)", "")
		str := RegExReplace(str, "(?<=\r\n)\d{2,3}\s", "")
		StringReplace, str, str, `r`n, , All 
		StringReplace, str, str, -, , All
	}
	else
	{
		str := RegExReplace(str, "\s\d{2,3}(?=\r\n)", "")
		str := RegExReplace(str, "(?<=\r\n)\d{2,3}\s", "")
		StringReplace, str, str, `r`n, %A_SPACE%, All   ;;复制文字后去掉剪切板中的换行符
	}
	; StringReplace, str, str, `r`n, %A_SPACE%, All   ;;复制文字后去掉剪切板中的换行符
	; ifinstring, str, Read more: http
	; {
		; str := RegExReplace(str, "Read more: http.*", "") 
	; }
	return str
}

translate(byref str)
{
	;msgbox, %str%
	if(is_chinese(str))
		POSTData := "hl=en&sl=zh-CN&ie=utf-8&tl=en&text="
	else
		POSTData := "hl=en&sl=en&ie=utf-8&tl=zh-CN&text="
		
	POSTData .= str
	
	url := "http://translate.google.com/"
	
	WebRequest := ComObjCreate("Microsoft.XMLHTTP")
	; WebRequest.Open("POST", url,False)
	
	WebRequest.Open("POST", url,true)
	WebRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8")
	WebRequest.setRequestHeader("Connection","keep-alive")
	WebRequest.setRequestHeader("Host","translate.google.cn")
	WebRequest.setRequestHeader("Content-Length", StrLen(POSTData))	
	WebRequest.Send(POSTData)

	;result := WebRequest.ResponseText
	
	while(WebRequest.ReadyState != 4)
	{
		sleep,100
		if(a_index>200)
		{
			TranslateStr := "获取数据超时...请再试一次!"
			return TranslateStr
		}
	}
	if WebRequest.ResponseText
		result := WebRequest.ResponseText
	else
	{
		TranslateStr:="数据为空，请确认已选择文本并检查网络连接。。。"
		return TranslateStr
	}
	RegExMatch(result, "TRANSLATED_TEXT='(.*)';INPUT_TOOL_PATH=", SubPat)  
	TranslateStr := SubPat1 
	return TranslateStr
}

translate_get(byref str)
{
	if(is_chinese(str))
		url:= "http://translate.google.cn/translate_a/t?client=t&sl=zh-CN&tl=en&hl=en&sc=2&ie=UTF-8&oe=UTF-8&q="
	else
		url:= "http://translate.google.cn/translate_a/t?client=t&sl=en&tl=zh-CN&hl=en&sc=2&ie=UTF-8&oe=UTF-8&q="
	url .= UrlEncode(str, "utf8")
	static WebRequest := ComObjCreate("Microsoft.XMLHTTP")
	WebRequest.Open("GET", url,true)
	;WebRequest.Open("GET", url,false)
	WebRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8")
	WebRequest.setRequestHeader("Connection","keep-alive")
	WebRequest.setRequestHeader("Host","translate.google.cn")
	WebRequest.setRequestHeader("Content-Length", StrLen(POSTData))	
	WebRequest.Send(POSTData)
	
	
	while(WebRequest.ReadyState != 4)
	{
		sleep,100
		if(a_index>200)
		{
			TranslateStr := "获取数据超时...请再试一次!"
			return TranslateStr
		}
	}
	result := WebRequest.ResponseText
	;msgbox, %result%
	RegExMatch(result, "\[\[\[""(.*?)""", SubPat)
	TranslateStr := SubPat1
	return TranslateStr
	
}

eliminate_unexpected_word(byref TranslateStr)
{
	loop
	{
		if(RegExMatch(TranslateStr, "\\x26quot;(.*)\\x26quot;" ,OutPutVar))
		{
			strQuote = "%OutPutVar1%"
			TranslateStr := RegExReplace(TranslateStr, "\\x26quot;(.*)\\x26quot;", strQuote)
		}
		else
			break
	}
}

show_translate_panel( TranslateStr, width)
{
	global PanelHwnd
	Gui, Panel:	New 
	Gui, Panel:	font, s11, Verdana 
	Gui, Panel:	Add, Text, -vscroll W%width%, %TranslateStr%
	Gui, Panel:	-Caption +HwndPanelHwnd +AlwaysOnTop     ;+AlwaysOnTop
	MouseGetPos, xpos, ypos
	ypos += 30
	
	Gui, Panel: Show, X%xpos% Y%ypos%
	
}

WM_LBUTTONDOWN()
{
	;Drag Gui
	PostMessage, 0xA1, 2
}

translate_to_clipboard(IsCopy = "yes")
{
	global PanelHwnd
	
	if(IsCopy = "yes")
	{
		clipboard=
		sleep,100
		send,^c
		clipwait,1
	}
	
	if clipboard=
	{
		suspend()
		sleep, 100
		send, ^d
		sleep, 200
		suspend()
		return
	}
		
	ifwinexist, ahk_id%PanelHwnd%
		winclose, ahk_id%PanelHwnd%	
	
	str:=clipboard
	
	preproccess_string(str)
	TranslateStr := translate_get(str)
	;TranslateStr := translate(str)
	eliminate_unexpected_word(TranslateStr)
	
	clipboard := TranslateStr
		
	if(is_chinese(TranslateStr))
		width := strlen(TranslateStr)*15 + 15
	else
		width := strlen(TranslateStr)*8 + 10
	
	if(width > 500)
		width := 500
	
	show_translate_panel(TranslateStr, width)
	OnMessage(0x201, "WM_LBUTTONDOWN")
	ifwinexist, ahk_id%PanelHwnd%
	{
		hotkey, MButton, on
		hotkey, Space, on
	}
	
}



;;translate function////////////



;;run program function////////////


run_program_path()
{
	WinGet, NowFile, ProcessPath, A
	OpenAndSelect=explorer.exe /select ,"%NowFile%"
	Run,%OpenAndSelect%
	return 
}

RunProgram(Name, path, visible=true)
{
	global WM_COMMAND
	process, exist, %Name%
	hWnd := errorlevel
	
	if (hWnd != 0)
	{
		if (Name="YodaoDict.exe")
		{
			process, close, %Name%
			process, close, WordBook.exe
			RefreshTray()
		}
		else
		{
			process, close, %Name%
			RefreshTray()
		}
	}
	else
	{
		if(visible=true)
			run, %path%
		else
			run, %path%, , hide
	}
	return
}

run_and_hide(Name, path, className)
{
	global WM_COMMAND
	ifwinexist, %className%
	{
		IfWinNotActive, %className%
		{	
			winactivate, %className%
			return
		}
	}
	process, exist, %Name%
	hWnd := errorlevel
	
	if (hWnd != 0)
	{
		IfWinExist %className%
			winhide, %className%
		else 
		{
			if(className="ahk_class EVERYTHING")
			{
				detecthiddenwindows, on
				sendmessage, WM_COMMAND, 0x00009C41,0x00000000, , ahk_class EVERYTHING_TASKBAR_NOTIFICATION
				detecthiddenwindows, off
			}
			else
			{	
				winshow, %className%
				winactivate, %className%
			}
		}
	}
	else
	{
		if(Name="TOTALCMD.EXE")
			run_totalcmd()
		else
			run, %path%
	}
	return
}

RefreshTray() 
{
   WM_MOUSEMOVE := 0x200

   ControlGetPos, xTray,, wTray,, ToolbarWindow321, ahk_class Shell_TrayWnd
   endX := xTray + wTray
   x := 5
   y := 19

   Loop
   {
      if (x > endX)
         break
      point := (y << 16) + x
      PostMessage, %WM_MOUSEMOVE%, 0, %point%, ToolbarWindow321, ahk_class Shell_TrayWnd
      x += 18
   }
}

open_helpfile(language)
{
	if(language="ahk")
	{
		ifwinexist, AutoHotkey 中文帮助
			winactivate, AutoHotkey 中文帮助
		else
			run, C:\Users\lcq\Desktop\HelpFiles\AutoHotkey.chm
	}
	if(language="py")
	{
		ifwinexist, Python v2.7.4 documentation
			winactivate, Python v2.7.4 documentation
		else
			run, C:\Users\lcq\Desktop\HelpFiles\python274.chm
	}
	return
}

run_totalcmd()
{
	run, D:\totalcmd\TOTALCMD.EXE
	winwait, ahk_class TNASTYNAGSCREEN
	winwaitactive, ahk_class TNASTYNAGSCREEN
	
	dm := ComObjCreate("dm.dmsoft")
	
	RegWinHwnd := dm.FindWindow("TNASTYNAGSCREEN","Total Commander")
	dm_ret := dm.SetDict(0,"C:\Users\lcq\Desktop\resource\dm_soft.txt")
	dm.BindWindow(RegWinHwnd,"gdi","normal","normal",0)
	s := dm.Ocr(229,198,245,215,"000000-c0c0c0",1.0)
	
	if(s="1")
		controlsend, , 1, ahk_class TNASTYNAGSCREEN
	else if(s="2")
		controlsend, , 2, ahk_class TNASTYNAGSCREEN
	else
		controlsend, , 3, ahk_class TNASTYNAGSCREEN
}

;;run program function////////////



;;Notepad++ function////////////

python_hotkey()
{
	Hotkey, IfWinActive, .*\.(py|ahk|AHK|PY) - Notepad++
	hotkey , $~= , off
	Input, OutPutVar, L1, {LControl}{RControl}{LAlt}{RAlt}{Left}{Right}{Up}{Down}{BS}
	if(OutPutVar = "")
	{
		hotkey , $~= , on
		return
	}
		
	If (OutPutVar <> "=")
	{
			Send,{left}{Space}{right}{Space}%OutPutVar%
			hotkey , $~= , on
			Return
	}
	
	Send, ={left 2}{Space}{right 2}{Space}
	hotkey , $~= , on
	Hotkey, IfWinActive
}

python_lt()
{
	Hotkey, IfWinActive, .*\.(py|ahk|AHK|PY) - Notepad++
	hotkey , $~= , off
	hotkey , $~> , off
	Input,OutPutVar,L1,{LControl}{RControl}{LAlt}{RAlt}{Left}{Right}{Up}{Down}{BS}
	if(OutPutVar = "")
	{
		hotkey , $~= , on
		hotkey , $~> , on
		Return
	}
	if(OutPutVar = ">")
	{
		send, %OutPutVar%
		hotkey , $~= , on
		hotkey , $~> , on
		return
	}
	If (OutPutVar <> "=")
	{
			Send,{left}{Space}{right}{Space}%OutPutVar%
			hotkey , $~= , on
			hotkey , $~> , on
			Return
	}
	
	Send, %OutPutVar%{left 2}{Space}{right 2}{Space}
	hotkey , $~= , on
	hotkey , $~> , on
	Hotkey, IfWinActive
	return
}

python_unequal()
{
	Hotkey, IfWinActive, .*\.(py|ahk|AHK|PY) - Notepad++
	hotkey , $~= , off
	Input, OutPutVar, L1, {LControl}{RControl}{LAlt}{RAlt}{Left}{Right}{Up}{Down}{BS}
	if(OutPutVar = "")
	{
		hotkey , $~= , on
		Return
	}
	If (OutPutVar <> "=")
	{
			Send,%OutPutVar%
			hotkey , $~= , on
			Return
	}
	
	Send, ={left 2}{Space}{right 2}{Space}
	hotkey , $~= , on
	Hotkey, IfWinActive
	Return		
}

python_equal()
{
	ifwinactive, .*\.(ahk|AHK) - Notepad++
	{	
		return
	}
	
	Input,OutPutVar,L1,{LControl}{RControl}{LAlt}{RAlt}{Left}{Right}{Up}{Down}{BS}
	if(OutPutVar="")
		return
	If (OutPutVar <> "=")
	{
			if(OutPutVar = """")
			{
				Send,{left}{Space}{right}{Space}%OutPutVar%
				Input,OutPutVar1,L1,
				send, %OutPutVar%{left}
				return
			}
			
			if(OutPutVar = "'")
			{
				Send,{left}{Space}{right}{Space}%OutPutVar%
				Input,OutPutVar1,L1,
				send, %OutPutVar%{left}
				return
			}
			
			Send,{left}{Space}{right}{Space}%OutPutVar%
			
			if (OutPutVar = "{")
				send,{{}
			Return
	}
	Send, ={left 2}{Space}{right 2}{Space}
	Return
	
}

;;Notepad++ function////////////



;;github commit function////////////

git_commit()
{
	global GithubFolder,ComenGui
	
	;;得到当前编辑文件名、文件类型、文件路径
	WinGetTitle, title, ahk_class Notepad++
	StringTrimRight, filePath, title, 12
	RegExMatch(title,".*(?=\s-)",filePath)
	RegExMatch(title, "U)[^\\]*(?=\s)", fileName)
	RegExMatch(fileName, "\..*\b", fileType)
	StringTrimLeft, fileType, fileType, 1, 1
	
	;;确认该文件类型已设置GIT同步， 并获取当前编辑文件GIT本地仓库文件夹处路径
	if(fileType = "ahk" || fileType = "AHK")
	{
		RegExMatch(filePath, "(\\[^\\]*)\.(ahk|AHK)", subpat)
		folder := GithubFolder . "\ahk"
		folder .= subpat1
	}
	else
	{
		msgbox, 当前编辑文件类型未设置github同步！
		return
	}
	
	;;如果本地仓库中文件夹存在并已加入git管理，则复制文件，COMMIT，PUSH，否则新建本地仓库文件夹
	if(FileExist(folder))
	{
		gitFolder := folder . "\.git"
		
		;;如果子文件夹中不存在.git文件夹， 询问是否将文件夹加入GIT管理
		if(!FileExist(gitFolder))
		{
			msgbox, 4, , 所在文件夹未加入git资料库管理， 是否加入？
			ifmsgbox, yes
				git_init(folder)
			else
				return			
		}
		
		;;复制文件并GIT ADD
		filecopy, %filePath%, %folder%, 1
		;msgbox, %folder%
		if(ErrorLevel != 0)
		{
			msgbox, 复制文件失败！
			return
		}
		Output := StdoutToVar_CreateProcess("git diff", "", folder)
		if(!Output)
		{
			traytip, , 两个文件相同！
			if(!StdoutToVar_CreateProcess("git diff --cached", "", folder))
				return
		}
		else
			Output := StdoutToVar_CreateProcess("git add " . fileName, "", folder)
	
	
		;;添加COMMENT
		ComenGui:= new CommentGUI("make your comment", "Comment")
		ComenGui.waitfor_input()
		
		;;GIT COMMIT
		Output := StdoutToVar_CreateProcess("git commit -m " . """" . ComenGui.Content . """", "", folder)
		ComenGui.Content:=
		Output := StdoutToVar_CreateProcess("git remote -v", "", folder)
		
		;;PUSH
		if(!Output)
		{
			traytip, , 此资料库未加入远程管理!
			return
			
		}
		else
		{
			Output := StdoutToVar_CreateProcess("git push origin master", "", folder)
			traytip, , %Output%
		}
		
	}
	else
	{
		msgbox, 4, , 当前文件未加入gitgub资料库管理， 是否加入？
		ifmsgbox, yes
		{
			FileCreateDir, %folder%
			sleep, 100
			git_init(folder)
			filecopy, %filePath%, %folder%, 1
			if(ErrorLevel != 0)
			{
				msgbox, 复制文件失败！
				return
			}
			Output := StdoutToVar_CreateProcess("git add " . fileName, "", folder)
			
			ComenGui:= new CommentGUI("enter your folder name", "folder name")
			ComenGui.waitfor_input()
			Output := StdoutToVar_CreateProcess("git commit -m " . """" . ComenGui.Content . """", "", folder)
			ComenGui.Content := ""
			msgbox, %Output%
		}
	}
	
	
}

git_init(folder)
{
	Output := StdoutToVar_CreateProcess("git init", "", folder)
	; msgbox, %Output%
	ifnotinstring, Output, Initialized empty Git repository
	{
		msgbox, git init 命令失败 ! 请检查文件夹参数是否正确。
		return
	}
	else
		traytip, , 初始化成功！
	
}

comment_gui()
{
	global Comment
	Gui, CommentPanel: New  
	Gui, CommentPanel: Add, Text,, Enter your comment:
	Gui, CommentPanel: Add, Edit, vComment ym  ; ym 选项开始一个新的控件列.
	Gui, CommentPanel: Add, Button, default ym , OK ; ButtonOK (如果存在的话) 会在此按钮被按下时运行.
	Gui, CommentPanel: Show,, Enter your comment
	return  ; 自动运行段结束. 在用户进行操作前脚本会一直保持空闲状态.
}
		
submit_comment()
{
	global Comment
	Gui, CommentPanel: Submit  ; 保存用户的输入到每个控件的关联变量中.
	if(!Comment)
	{
		traytip, , Comment不能为空, 请重新输入。
		Gui, CommentPanel: Show,, Enter your comment
		return
	}
	Gui, CommentPanel: Destroy
	return
}

;;github commit function////////////



;;adobe acrobat function////////////

click_pic(picRoute)
{
	CoordMode,Pixel|Mouse, Window
	MouseGetPos,orinx,oriny 
	imagesearch, intx, inty, 0, 0, 1366, 768, *10 %picRoute%
	intx += 5
	inty += 5
	winget,winid,id,A
	SetControlDelay -1
	ControlClick, x%intx% y%inty%, ahk_id %winid%,,,, NA
	CoordMode,Pixel|Mouse, Screen
}

;;adobe acrobat function////////////



;;clipboard function////////////

search_baidu()
{	
	Oldclipboard := clipboard
	clipboard=
	sleep,200
	send,^c
	clipwait,300
	ie := ComObjCreate("InternetExplorer.Application")
	ie.Visible := true  ; 已知这个语句在 IE7 上无法正常执行.
	url := "http://www.baidu.com/s?word=" . UrlEncode(clipboard)
	ie.Navigate(url)
	while ie.Busy
		sleep, 100
	while ie.document.readystate!="complete"
		sleep,100
	clipboard := Oldclipboard
}


remove_endline()
{
	clipboard=
	sleep,200
	send,^c
	clipwait,300
	clipboard:=preproccess_string(clipboard)
	;StringReplace, clipboard, clipboard, `r`n, , All
}

;;clipboard function////////////



;;captureScreen function////////////

CaptureGUI()
{
	global Matrix, ZoomState
	CoordMode, Mouse, Screen
	MouseGetPos, startX, startY
	Gui, captureRect:New  
	Gui, captureRect:    +LastFound +AlwaysOnTop +HwndRectHwnd
	Gui, captureRect:    Color, EEAA99
	WinSet, Transparent, 150
	Gui, captureRect:    Font, s20 
	Gui, captureRect:    -Caption
	Gui, captureRect:    Add, Text, Cblue vMatrix, >>>>截取屏幕
	;;zoom window 
	
	
	
	
	while(GetKeyState("LCONTROL",P)=1 && GetKeyState("LALT",P)=1)   ;;如果ctrl和alt按下, 进入循环
	{
		Sleep,10
		KeyIsDown := GetKeyState("LCONTROL")
		if (KeyIsDown = 0)   ;;如果ctrl释放, 确定截图区域
		{
			;traytip,, %pxpos% %nxpos% %xpos% %pypos% %nypos% %ypos%
			;Getfont(%pxpos%,%pypos%,%xpos%,%ypos%)
			MouseGetPos, endX, endY
			width = % endX - startX
			height = % endY - startY
			Gui, captureRect:    +LastFound +AlwaysOnTop
			Gui, captureRect:    Color, EEAA99
			WinSet, Transparent, 150
			Gui, captureRect:    Font, s10 
			Gui, captureRect:    Add, Text, Cblue, >>>>截取屏幕
			Gui, captureRect:    -Caption 
			Gui, captureRect:    Show, x%startX% y%startY% h%height% w%width%
			sleep, 100
			OnMessage(0x201, "WM_LBUTTONDOWN")   
			return
		}
		MouseGetPos, xpos, ypos
		nxpos = % xpos - startX
		nypos = % ypos - startY
		ControlSetText, Static1, %nxpos%×%nypos%, ahk_id %RectHwnd%
		Gui, captureRect:    Font, s10
		Gui, captureRect:    Add, Text, Cblue, >>>>截取屏幕
		Gui, captureRect:    Font, s20
		Gui, captureRect:    Show, x%startX% y%startY% h%nypos% w%nxpos% 
		OnMessage(0x201, "WM_LBUTTONDOWN") 
          
	}
}

FixedCapture()
{
	global Content, ComenGui
	ComenGui:= new CommentGUI("input matrix", "matrix")
	ComenGui.waitfor_input()
	StringSplit, demension, Content, %A_Tab%%A_Space% ,
	ComenGui.Content:=
	FixedCaptureGUI(demension1, demension2)
}


FixedCaptureGUI(width, height)
{
	global nMatrix, Content
	CoordMode, Mouse, Screen
	MouseGetPos, startX, startY
	Gui, captureRect2:New  
	Gui, captureRect2:    +LastFound +AlwaysOnTop +HwndRectHwnd
	Gui, captureRect2:    Color, EEAA99
	WinSet, Transparent, 150
	Gui, captureRect2:    -Caption
	Gui, captureRect2:    Font, s20
	loop 30
	{
		
		Gui, captureRect2:    Add, Text, Cblue, >>>>截取屏幕
	}
	
	Gui, captureRect2:    Font, s20
	Gui, captureRect2:    Show, x%startX% y%startY% h%height% w%width% 
	ControlSetText, Static1, %width%×%height%, ahk_id %RectHwnd%
	OnMessage(0x201, "WM_LBUTTONDOWN") 
          
}

CaptureImage(clip=0)
{
	picNum:=0
	wingetpos,  GUI_X, GUI_Y, GUI_Width, GUI_Height, ahk_class AutoHotkeyGUI, >>>>截取屏幕
    Gui, captureRect:    hide
	Gui, captureRect2:    hide
    sleep,100
	endPointX := GUI_X + GUI_Width
	endPointY := GUI_Y + GUI_Height
	rect=%GUI_X%, %GUI_Y%, %endPointX%, %endPointY%
    path := A_ScriptDir . "\" . picNum . ".png"
	while(FileExist(path))
    {
		picNum++
		path := A_ScriptDir . "\" . picNum . ".png"
	}
	if(clip=0)
		CaptureScreen(rect, False, path)
	else
		CaptureScreen(rect, False, 0)
	
    return
}

CaptureClient(i)
{
	picNum:=0
	path := A_ScriptDir . "\" . picNum . ".png"
	while(FileExist(path))
    {
		picNum++
		path := A_ScriptDir . "\" . picNum . ".png"
	}
	CaptureScreen(i, False, 0)
	CaptureScreen(i, False, path)
    return
}

;;captureScreen function////////////



;;login seu-wlan function////////////

Connect_seu_wlan()
{
	isSeuWebExist := instr(StdoutToVar_CreateProcess("netsh wlan show networks"), "seu-wlan")
	if(!isSeuWebExist)
	{
		msgbox, 此区域未找到seu-wlan网络，请确认已开启无线，并核实seu-wlan网络存在。
		return 0
	}
	isWlanConnect := instr(StdoutToVar_CreateProcess("netsh wlan show interface"), "seu-wlan")
	if(!isWlanConnect)
	{
		profiles := StdoutToVar_CreateProcess("netsh wlan show profiles")
		
		ifinstring, profiles, seu-wlan
			result := StdoutToVar_CreateProcess("netsh wlan connect name=seu-wlan ssid=seu-wlan")
		else
		{
			result := StdoutToVar_CreateProcess("netsh wlan add profile filename=""D:\Program Files\seu_dial\seu-wlan.xml""")
			;msgbox, %result%
			sleep, 50
			result := StdoutToVar_CreateProcess("netsh wlan connect name=seu-wlan ssid=seu-wlan")
		}
		
		ifinstring, result, 成功
			traytip, Notice, 成功连接seu_wlan..., , 1
	}
	return 1
}

login_webseu(username, password)
{

	postdata := "username=" . username . "&password=" . password
	WebRequest := ComObjCreate("Microsoft.XMLHTTP")
	WebRequest.Open("POST", "https://w.seu.edu.cn/portal/login.php",False)
	WebRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8")
	WebRequest.setRequestHeader("Content-Length", StrLen(postdata))
	WebRequest.Send(postdata)
	result := WebRequest.ResponseText
	;fileappend, %result%, test.txt
	ifinstring, result, success
		traytip, Notice, 已成功登录seu_wlan..., , 1
	else ifinstring, result, \u60a8\u7684Web\u8ba4\u8bc1\u670d\u52a1\u5df2\u8d85\u671f
		{
			msgbox, web认证提示已超期，请进行充值!
			return 0
		}
		else ifinstring, result, \u60a8\u5c1a\u672a\u5f00\u901aWeb\u8ba4\u8bc1\u670d\u52a1\
			{
				msgbox, web认证提示服务未开通，请确认您已开通Web认证服务，并核对您的一卡通号及密码!
				return 0
			}
	
	return 1
}

login_seu_wlan()
{
	IfNotExist, D:\Program Files\seu_dial
		FileCreateDir, D:\Program Files\seu_dial
	
	IfNotExist, D:\Program Files\seu_dial\seu-wlan.xml
		fileinstall, C:\Users\lcq\Desktop\resource\seu-wlan.xml, D:\Program Files\seu_dial\seu-wlan.xml, 1
	
	Connect_seu_wlan()
	sleep, 1000
	loop 5
	{
		if(a_index=5)
		{
			msgbox,16, , ERROR_LOGIN_SEU %ERROR_LOGIN_SEU%
			exitapp
		}
		try login_webseu("220132840", "264914")
		catch e
		{
			sleep, 2000
			continue
		}
		break
	}
}

;;login seu-wlan function////////////



;;create folder and open with notepad++//////////////////////

OpenWithNotepadPP()
{
	clipOld := ClipboardAll
	copy_to_clip()
	clipboard=%clipboard% ;这句还是废话一下：windows 复制的时候，剪贴板保存的是“路径”。只是路径不是字符串，只要转换成字符串就可以粘贴出来了。
	
	ifexist, %clipboard%
		run, %comspec% /k "D:\Program Files\Notepad++\notepad++.exe" %clipboard%, , hide
		
	Clipboard := clipOld   
	return
}
 

;;create folder//////////////////////



;;function uncommon uesed////////////

get_mouse_cood()
{
	mousegetpos, x, y, winname, controlname
	tooltip, %x% %y%
	sleep, 1500
	tooltip,
	return
}

send_html_frame()
{
html1 =
(
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
		
)

html2 =
(
	</head>
	
<body>
	
</body>

)
	keywait,LWin
	send %html1%
	send {BS 2}
	send %html2%
	send {BS}
	send </html>{up 2}{tab}
	return
}

;;function uncommon uesed////////////



;;anjian jinglin////////////

Dubug_AnJian()
{
	global WM_COMMAND
	winget, Cid, id, A
	SendMessage, WM_COMMAND, 0x000080E5, 0, , ahk_id %Cid%
}

create_new()
{

	global WM_COMMAND
	winget, Cid, id, A
	ControlGet, OutputHwnd, Hwnd,,SysListView322, ahk_id %Cid%
	FirParentWin:= DllCall("GetParent", "uint", OutputHwnd) 
	NextParentWin:= DllCall("GetParent", "uint", FirParentWin) 
	SendMessage, WM_COMMAND, 0x00008029, 0, , ahk_id %NextParentWin%
}

save_exit()
{
	global WM_COMMAND
	winget, Cid, id, A
	SendMessage, WM_COMMAND, 0x000080DB, 0, , ahk_id %Cid%
}

modify_script()
{

	global WM_COMMAND
	winget, Cid, id, A
	ControlGet, OutputHwnd, Hwnd,,SysListView322, ahk_id %Cid%
	FirParentWin:= DllCall("GetParent", "uint", OutputHwnd) 
	NextParentWin:= DllCall("GetParent", "uint", FirParentWin) 
	SendMessage, WM_COMMAND, 0x0000802A, 0, , ahk_id %NextParentWin%
}

;;anjian jinglin////////////



;////////FunctionFunctionFunctionFunctionFunctionFunctionFunctionFunctionFunctionFunction

