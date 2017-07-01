import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, removeKeys)
import System.IO
import System.Exit

baseConfig = desktopConfig

main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ baseConfig
        { terminal   = "terminator"
        , modMask    = mod4Mask
        , borderWidth = myBorderWidth
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , manageHook = manageDocks <+> manageHook baseConfig
        , layoutHook = avoidStruts  $  layoutHook baseConfig
        , logHook    = (myLogHook xmproc) <+> logHook baseConfig
        , workspaces = myWorkspaces
        }
        `removeKeys` myRemoveKeys
        `additionalKeys` myAddKeys

myTerminal = "terminator"

myModMask = mod4Mask

myBorderWidth = 3

myNormalBorderColor = "#bbbbbb"

myFocusedBorderColor = "#5599dd"

myLogHook xmproc = dynamicLogWithPP xmobarPP
    { ppOutput  = hPutStrLn xmproc
    , ppTitle   = xmobarColor "grey" "" . shorten 50
    , ppCurrent = xmobarColor "white" "" . wrap "" ""
    }

myWorkspaces = ["1:TERM", "2:WEB", "3:CODE"] ++ map show [4..9]

myRemoveKeys = [ (mod4Mask .|. shiftMask, xK_space)
               , (mod4Mask, xK_q)
               , (mod4Mask .|. shiftMask, xK_q)
               , (mod4Mask, xK_p)
               , (mod4Mask .|. shiftMask, xK_c)
               , (mod4Mask .|. shiftMask, xK_Return)
               , (mod4Mask, xK_space)
               ]

-- Alternate rofi command "rofi -show run -lines 3 -line-margin 25 -opacity 75 -font 'Input Mono 28' -width 100 -padding 700 -hide-scrollbar")

myAddKeys =  [ ((0,                    0x1008ff11), spawn "amixer set Master 5%-")
             , ((0,                    0x1008ff13), spawn "amixer set Master 5%+")
             , ((0,                    0x1008ff12), spawn "amixer set Master toggle")
             , ((mod4Mask,              xK_Return), spawn "terminator")
             , ((mod4Mask .|. shiftMask, xK_space), sendMessage NextLayout)
             , ((mod4Mask,               xK_space), spawn "rofi -show run -font 'Input Mono 24'")
             , ((mod4Mask .|. shiftMask,     xK_r), spawn "xmonad --restart")
             , ((mod4Mask .|. shiftMask,     xK_e), io (exitWith ExitSuccess))
             , ((mod4Mask,                   xK_q), kill)
             , ((0,                    0x1008ff03), spawn "xbacklight -time 0 -dec 5")
             , ((0,                    0x1008ff02), spawn "xbacklight -time 0 -inc 5")
             ]
