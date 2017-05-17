import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

baseConfig = desktopConfig

main = do
  xmonad $ baseConfig
    { terminal = "terminator"
    , modMask  = mod4Mask
    , manageHook = manageDocks <+> manageHook baseConfig
    , layoutHook = avoidStruts  $  layoutHook baseConfig
    }
