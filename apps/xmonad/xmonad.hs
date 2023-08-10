import XMonad

import XMonad.Util.EZConfig
import XMonad.Layout.Spacing
import XMonad.StackSet as W
import XMonad.Actions.DynamicWorkspaceOrder as DO
import XMonad.Actions.CycleWS
import XMonad.Util.Types

myModMask = mod4Mask
myTerminal = "wezterm"
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]
myKeys = [ ("M-r", spawn "rofi -show drun")   -- Rofi
         , ("M-<Return>", spawn myTerminal)   -- Open Terminal
         , ("M-S-<Return>", windows W.swapMaster) -- Set to master
         , ("M-w", kill)                      -- Close window
         ] ++
         [ (otherModMasks ++ "M-" ++ [key], action tag)
           | (tag, key)  <- zip myWorkspaces "123456789"
           , (otherModMasks, action) <- [ ("", windows . W.view) -- was W.greedyView
                                           , ("S-", windows . W.shift)]
         ]
myLayout = smartSpacing 10 $ tiled ||| Mirror tiled ||| Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

myStartup :: X ()
myStartup = spawn $ foldr1 (\a b -> a ++ " ; " ++ b) -- startup tasks
    [ "feh --bg-scale ~/.nix/car.jpg"
    , "pkill gpg-agent"
    , "gpg-agent --pinentry-program=/etc/profiles/per-user/dukk/bin/pinentry-qt --daemon"
    , "picom --config ~/.nix/apps/picom/picom.conf"
    ]

main :: IO ()
main = xmonad $ def
    { modMask    = myModMask
    , terminal   = myTerminal
    , layoutHook = myLayout
    }
    `additionalKeysP` myKeys
