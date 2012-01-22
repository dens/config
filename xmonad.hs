import XMonad
import XMonad.Config.Gnome

import XMonad.Core as XMonad hiding
    (workspaces,manageHook,numlockMask,keys,logHook,startupHook,borderWidth,mouseBindings
    ,layoutHook,modMask,terminal,normalBorderColor,focusedBorderColor,focusFollowsMouse
    ,handleEventHook)
import qualified XMonad.Core as XMonad
    (workspaces,manageHook,numlockMask,keys,logHook,startupHook,borderWidth,mouseBindings
    ,layoutHook,modMask,terminal,normalBorderColor,focusedBorderColor,focusFollowsMouse
    ,handleEventHook)

import XMonad.Layout
import XMonad.Layout.NoBorders
import XMonad.Operations
import XMonad.ManageHook
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import XMonad.StackSet (RationalRect (RationalRect))
import Data.Bits ((.|.))
import Data.Monoid
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import Graphics.X11.Xlib.Extras

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.Window
import XMonad.Prompt.Man

-- | The xmonad key bindings. Add, modify or remove key bindings here.
--
-- (The comment formatting character is used when generating the manpage)
--
mykeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
mykeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask,    xK_x), spawn $ XMonad.terminal conf) -- %! Launch terminal
    -- , ((modMask,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"") -- %! Launch dmenu
    -- , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun") -- %! Launch gmrun
    , ((modMask,    xK_c     ), kill) -- %! Close the focused window
    -- , ((modMask,    xK_z     ), withFocused hide) -- %! Iconify the focused window

    , ((modMask,               xK_z), shellPrompt defaultXPConfig) 
    , ((modMask .|. shiftMask, xK_z), xmonadPrompt defaultXPConfig)
    , ((modMask,               xK_a), windowPromptGoto defaultXPConfig)
    , ((modMask .|. shiftMask, xK_slash), manPrompt defaultXPConfig)

    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((modMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_s     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,               xK_w     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((modMask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((modMask .|. shiftMask, xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- toggle the status bar gap
    -- , ((modMask              , xK_b     ), modifyGap (\i n -> let x = (XMonad.defaultGaps conf ++ repeat (0,0,0,0)) !! i in if n == x then (0,0,0,0) else x))
      
    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modMask              , xK_q     ), spawn "xmonad --recompile && xmonad --restart") -- %! Restart xmonad
    ]
    ++
    -- mod-[1..8] %! Switch to workspace N
    -- mod-shift-[1..8] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_8]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++
    -- -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    -- [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myManageHook = composeAll
               [ className =? "MPlayer"        --> doFloat
               , className =? "Gimp"           --> doFloat
               , className =? "Gcalctool"      --> doFloat 
               , (className =? "Firefox" <&&> resource =? "Download") --> doRectFloat (RationalRect 0.6 0.7 0.4 0.275)
               ]

main = do
  putStrLn "Hello XMonad!"
  xmonad gnomeConfig { 
    layoutHook = smartBorders $ layoutHook gnomeConfig,
    modMask = mod4Mask, 
    terminal = "term",
    workspaces = map show [1 .. 8 :: Int],
    keys = mykeys,
    borderWidth = 2,
    focusFollowsMouse = True,
    manageHook = manageDocks <+> myManageHook <+> manageHook gnomeConfig
    }

