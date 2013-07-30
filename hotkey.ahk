#SingleInstance force 

#include  <message> 		;;包含Messge库

SetBatchlines -1              ;;全速运行

SetTitleMatchMode,RegEx       ;;窗口匹配方式为正则匹配

sendmode input                ;;send模式为input

ComObjError(false)			  ;;关闭Com错误信息

CoordMode, Mouse, Screen      ;;鼠标坐标轴为屏幕

CoordMode, ToolTip, Screen    ;;工具条坐标轴为屏幕

ActiveWinHwnd :=              ;;激活窗口ID

Xdelta := 50				  ;;横向窗口移动量

Ydelta := 30				  ;;纵向窗口移动量

CloseState:="on"              ;;开启自动关闭CMD窗口

hotkey, MButton, off          ;;初始设置中键快捷键为关闭

hotkey, ESC, off			  ;;初始设置ESC快捷键为关闭	

PanelHwnd := ""				  ;;初始化翻译界面句柄

if(is_snadial_run())
{
	hotkey, ^!b, off
	hotkey, ^!a, off
}

loop	
	{
		CloseCMD()
		sleep, 3000
	}
			

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

#g::	;;get active window ID
	ActiveWinHwnd := get_active_win()
	return
	
#c::
	run, %windir%\system32\calc.exe
	return

#t::	;;set active window on top
	set_win_ontop()
	return

^#up::	;;set active window size to top half screen
	set_win_pos(0, 0, A_ScreenWidth, A_ScreenHeight/2)
	return

^#down::	;;set active window size to bottom half screen
	set_win_pos(0, A_ScreenHeight/2, A_ScreenWidth, A_ScreenHeight/2)
	return

#up::	;;miximize active window
	MaximizeWin()
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


#v::	;;hide tray window
	hide_tray()
	return

^d::	;;translate specified English sentences
	translate_to_clipboard()
	return
	
MButton::   ;;exit translate panel
ESC::		;;exit translate panel
	Gui, Panel:	destroy
	IfWinNotExist , ahk_id%PanelHwnd%
	{
		hotkey, MButton, off
		hotkey, ESC, off
	}
	return

^t::	;;translate specified English sentences from clipboard
	Translate_to_clipboard("no")
	return

^!b::	;;dial bras b
	run, snadial.ahk -v -b
	hotkey, ^!b, off
	hotkey, ^!a, off
	return


^!a::	;;dial bras a
	run, snadial.ahk -v -a
	hotkey, ^!b, off
	hotkey, ^!a, off
	return

#w::	;;launch wifi
	run,%comspec% /c Wifi_Launcher.cmd
	return


#f::	;;launch everything.exe
	RunProgram("Everything.exe", "D:\Small software\Everything\Everything.exe")
	return

LWin & F1:: 	;;launch youdao dictionary， window hidden
	RunProgram("YodaoDict.exe", "C:\Users\lcq\AppData\Local\Youdao\Dict\Application\YodaoDict.exe", false)
	return

LControl & F1:: 	;;launch youdao dictionary
	RunProgram("YodaoDict.exe", "C:\Users\lcq\AppData\Local\Youdao\Dict\Application\YodaoDict.exe")
	return

SHIFT & mButton::	;;get mouse coordinate
	get_mouse_cood()
	return

#h::	;;send html frame
	send_html_frame()
	return

^!o::	;;run path of active program
	run_program_path()
	return

	
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

#r::
	window()
	return

q::Numpad7

space::Numpad8

LWin::return

$s::
	send ,s
	sleep, 90	
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

,::
	send,,%a_space%
	return


#IfWinActive





;//////HotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkeyHotkey

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
suspend()
{

	if A_IsSuspended
		suspend,off
	else
		suspend,on
		
	return
}

get_active_win()
{
	winget,ActiveWinId,id,A
	wingettitle,title,ahk_id %ActiveWinId%
	traytip,,得到%title%的句柄。。。
	return ActiveWinId
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

set_win_pos(left, top, width, height)
{
	global WM_SYSCOMMAND
	winget,Cid,id,A
	;winmove, ahk_id %Cid%, , left, top, width, height
	DllCall("MoveWindow", "UInt", Cid, "Int", left, "Int", top, "Int", width, "Int", height, "Int", 1)
	sendmessage, WM_SYSCOMMAND, 0x0000F122, 0x00120250, , ahk_id %Cid%
}

MaximizeWin()
{
	global WM_SYSCOMMAND
 	winget,Cid,id,A
;	WinMinimize, ahk_id %Cid%
	;WinMaximize, ahk_id %Cid% 
	sendmessage, WM_SYSCOMMAND, 0x0000F030, 0x0006026A, , ahk_id %Cid%
	
	return
}

window()
{
	winget,Cid,id,A
	winmove, ahk_id %Cid%, , 0, 0, 800, 600 
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

hide_tray()
{
	IfWinExist,ahk_class Shell_TrayWnd
	{
		WinHide,ahk_class Shell_TrayWnd
		WinHide,开始 ahk_class Button
	}
	Else
	{
		WinShow,ahk_class Shell_TrayWnd
		WinShow,开始 ahk_class Button
	}
}

translate_to_clipboard(IsCopy = "yes")
{
	global PanelHwnd
	
	if(IsCopy = "yes")
	{
		clipboard=
		sleep,200
		send,^c
		clipwait,2
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
	
	TanslateStr := translate(str)
	
	eliminate_unexpected_word(TanslateStr)
	
	clipboard := TanslateStr
		
	if(is_chinese(TanslateStr))
		width := strlen(TanslateStr)*15 + 15
	else
		width := strlen(TanslateStr)*9 + 15
	
	if(width > 400)
		width := 400
	
	show_translate_panel(TanslateStr, width)
	OnMessage(0x201, "WM_LBUTTONDOWN")
	
	ifwinexist, ahk_id%PanelHwnd%
	{
		hotkey, MButton, on
		hotkey, ESC, on
	}
	
}

show_translate_panel( TanslateStr, width)
{
	global PanelHwnd
	Gui, Panel:	New 
	Gui, Panel:	font, s11, Verdana 
	Gui, Panel:	Add, Text, -vscroll W%width%, %TanslateStr%
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

StrPutVar(string, ByRef var, encoding)
{
    ; 确定容量.
    VarSetCapacity( var, StrPut(string, encoding)
        ; StrPut 返回字符数, 但 VarSetCapacity 需要字节数.初始化为0
        * ((encoding="utf-16"||encoding="cp1200") ? 2 : 1), 0)
    ; 复制或转换字符串.
    return StrPut(string, &var, encoding)
}

is_chinese(str)
{
	str :=  LTrim(str, "0123456789 `t“”")
	NewStr := SubStr(str, 1, 1)
	StrPutVar(NewStr, var, "utf-8")
	number := NumGet(var, 0, "UInt")
	if(number > 256)
		return true
	else
		return false	
}

preproccess_string(byref str)
{
	StringReplace, str, str, `r`n, %A_SPACE%, All   ;;复制文字后去掉剪切板中的换行符
	ifinstring, str, Read more: http
	{
		str := RegExReplace(str, "Read more: http.*", "") 
	}
}

translate(byref str)
{
	
	if(is_chinese(str))
		POSTData := "hl=en&sl=zh-CN&ie=utf-8&tl=en&text="
	else
		POSTData := "hl=en&sl=en&ie=utf-8&tl=zh-CN&text="
		
	POSTData .= str
	
	url := "http://translate.google.com/"
	
	WebRequest := ComObjCreate("Microsoft.XMLHTTP")
	WebRequest.Open("POST", url,False)
	WebRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8")
	WebRequest.setRequestHeader("Connection","keep-alive")
	WebRequest.setRequestHeader("Host","translate.google.cn")
	WebRequest.setRequestHeader("Content-Length", StrLen(POSTData))
	WebRequest.Send(POSTData)
	
	result := WebRequest.ResponseText
	RegExMatch(result, "TRANSLATED_TEXT='(.*)';INPUT_TOOL_PATH=", SubPat)  
	TanslateStr := SubPat1 
	return TanslateStr
}

eliminate_unexpected_word(byref TanslateStr)
{
	loop
	{
		if(RegExMatch(TanslateStr, "\\x26quot;(.*)\\x26quot;" ,OutPutVar))
		{
			strQuote = "%OutPutVar1%"
			TanslateStr := RegExReplace(TanslateStr, "\\x26quot;(.*)\\x26quot;", strQuote)
		}
		else
			break
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

RunProgram(Name, path, visible=true)
{
	process, exist, %Name%
	hWnd := errorlevel
	
	if (hWnd != 0)
	{
		if (Name="YodaoDict.exe")
		{
			process, close, %Name%
			process, close, WordBook.exe
		}
		else
			process, close, %Name%
		RefreshTray() 
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

run_program_path()
{
	WinGet, NowFile, ProcessPath, A
	OpenAndSelect=explorer.exe /select ,"%NowFile%"
	Run,%OpenAndSelect%
	return 
}

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
;////////FunctionFunctionFunctionFunctionFunctionFunctionFunctionFunctionFunctionFunction

