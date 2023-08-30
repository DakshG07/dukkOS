import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Types
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.StackSet as W
import XMonad.Actions.DynamicWorkspaceOrder as DO
import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks

myModMask    = mod4Mask
myTerminal   = "wezterm"
myWorkspaces = show <$> [1,2,3,4,5,6,7,8,9]
myScreenshot = spawn "maim -s -u | xclip -selection clipboard -t image/png -i"
myVolumeUp   = spawn "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
myVolumeDown = spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
myVolumeMute = spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
myKeys = [ ("M-r", spawn "rofi -show drun")       -- Rofi
         , ("M-<Return>", spawn myTerminal)       -- Open Terminal
         , ("M-S-<Return>", windows W.swapMaster) -- Set to master
         , ("M-w", kill)                          -- Close window
         , ("M-S-s", myScreenshot)                -- Screenshot
         , ("<XF86AudioRaiseVolume>", myVolumeUp)
         , ("<XF86AudioLowerVolume>", myVolumeDown)
         , ("<XF86AudioMute>", myVolumeMute)
         -- TODO: brightness control
         ] ++
         [ (otherModMasks ++ "M-" ++ [key], action tag)
           | (tag, key)  <- zip myWorkspaces "123456789"
           , (otherModMasks, action) <- [ ("", windows . W.view) -- was W.greedyView
                                           , ("S-", windows . W.shift)]
         ]
-- whilst it's suggested to use avoidStruts AFTER applying any screen gaps,
-- we disregard this since we intend for there to be an extra gap at the top (between the bar)
myLayout = avoidStruts $ gaps [(R,18),(L,18),(D,18),(U,5)] $ smartBorders $ spacingRaw True (Border 0 0 0 0) False (Border 10 10 10 10) True $ tiled ||| Mirror tiled ||| Full
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
myStartup = foldr (\x xs -> xs >> (spawn x)) (spawn "") -- startup tasks
    [ "feh --bg-scale ~/.nix/wallpaper.png"
    , "pkill gpg-agent && gpg-agent --pinentry-program=/etc/profiles/per-user/dukk/bin/pinentry-qt --daemon"
    , "picom --config ~/.nix/dotfiles/picom/picom.conf"
    , "polybar -q --reload main"
    , "polybar -q --reload monitor"
    ]

myLogHook = updatePointer (0.5, 0.5) (0, 0) -- bring my cursor with me!

main :: IO ()
main = do
         xmonad $ docks . ewmhFullscreen . ewmh $ def
           { modMask     = myModMask
           , terminal    = myTerminal
           , layoutHook  = myLayout
           , startupHook = myStartup
           , logHook     = myLogHook
           , normalBorderColor = "#1e1e2e"
           , focusedBorderColor = "#f5c2e7"
           , borderWidth = 5
           }
           `additionalKeysP` myKeys
