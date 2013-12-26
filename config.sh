# colors

BG="#3a3a3a"
FG="#d7d7d7"

# black / red
BLACK="#d7d7af"
RED="#d78787"
# green / yellow
GREEN="#87af87"
YELLOW="#e1e176"
# bleu / purple
BLUE="#99a0b9"
# COL5="#87d7d7"
PURPLE="#9772ad"
# cyan / white
CYAN="#72ada4"
WHITE="#afa489"
# + black / red
BR_BLACK="#709080"
BR_RED="#dca3a3"
# + green / yellow
BR_GREEN="#c3bf9f"
BR_YELLOW="#f0dfaf"
# + bleu / purple
BR_BLUE="#94bff3"
BR_PURPLE="#ec93d3"
# + cyan / white
BR_BLUE="#94bff3"
BR_WHITE="#ffffff"


# icons

ICO_PLAY="^i($(get_icon play.xbm))"
ICO_STOP="^i($(get_icon stop.xbm))"
ICO_PAUSE="^i($(get_icon pause.xbm))"
ICO_MUSIC="^i($(get_icon note.xbm))"
ICO_CPU="^i($(get_icon cpu.xbm))"
ICO_MEM="^i($(get_icon mem.xbm))"
ICO_NWDOWN=`set_fg_color GREEN "^i($(get_icon net_down_03.xbm))"`
ICO_NWUP="^i($(get_icon net_up_03.xbm))"


# string formatter elements
BEGIN=$(set_fg_color GREEN "[    ")
SEPARATOR=$(set_fg_color GREEN "    |    ")
END=$(set_fg_color GREEN "    ]")

# font
FONT='-*-courier-medium-r-normal-*-12-*-*-*-*-*-iso8859-1'

# window geometry and placement
WIN_HEIGHT=15
WIN_WIDTH=
X_SCREEN=

# time to sleep between each loop
SLEEP=1
