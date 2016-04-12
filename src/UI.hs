module UI(web) where
import Graphics.UI.Gtk
import Graphics.UI.Gtk.Entry.Entry
import Graphics.UI.Gtk.WebKit.WebView
import Graphics.UI.Gtk.WebKit.WebSettings
import System.Glib.UTFString
import Foreign.C.String

web = do
    -- initialize Gtk
    _ <- initGUI
    -- create a new window, a vertical box, to hold an
    -- entry bar, and a scrolled window, and a webview
    w   <- windowNew
    v   <- vBoxNew False 2
    bar <- entryNew
    sw  <- scrolledWindowNew Nothing Nothing
    wv  <- webViewNew
    -- set the child of the parent to the vbox,
    -- and set some others attributes
    set w
        [ containerChild       := v
        , windowDefaultWidth   := 640
        , windowDefaultHeight  := 480
        , containerBorderWidth := 1
        , windowTitle          := "Spider"
        ]
    -- now pack the bar and then the scrolled window
    boxPackStart v bar PackNatural 0
    boxPackStart v sw PackGrow 0
    -- set the child of the scrolled windows to the webview.
    set sw [ containerChild := wv ]
    -- when we activate the entry bar (typically pressing enter),
    -- we execute the following code: get the text from the entry and
    -- load the uri from the entry.
--    onEntryActivate bar (entryGetText bar >>= webViewLoadUri wv)
    on bar entryActivated ((entryGetText bar :: IO [Char]) >>= webViewLoadUri wv)
    onDestroy w mainQuit
    widgetShowAll w
    mainGUI