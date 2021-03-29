Config { font = "-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*"
       , additionalFonts = []
       , borderColor = "black"
       , border = TopB
       , bgColor = "black"
       , fgColor = "grey"
       , alpha = 255
       , position = Top
       , textOffset = -1
       , iconOffset = -1
       , lowerOnStart = True
       , pickBroadest = False
       , persistent = False
       , hideOnStart = False
       , iconRoot = "."
       , allDesktops = True
       , overrideRedirect = True
       , commands = [ Run Com "uname" ["-s","-r"] "" 36000
                    , Run Date "%a %_d %b %Y - %H:%M:%S" "date" 10
		    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }\
                     \{ %uname% ||| <fc=#ee9a00>%date%</fc>"
       }
