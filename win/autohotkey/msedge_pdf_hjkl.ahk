if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), ".pdf") {
    Space & h::Left
    Space & j:: {
        while GetKeyState("j", "P") {
            Send "{Down}"
            Sleep 10
        }
    }
    Space & k:: {
        while GetKeyState("k", "P") {
            Send "{Up}"
            Sleep 10
        }
    }
    Space & l::Right
    Space:: Send " "
}
