#
# Wheelwriter 1000 Matrix
#
# Top two keys in the 5-key vertical block are PgUp/PgDn respectively.
# Bottom two keys in the 5-key vertical block are F11/F12 respectively.
#
# The middle key in the 5-key vertical block on the right can be used as follows:
# [Modifier]-WASD : Cursor keys (Up/Left/Down/Right)
# [Modifier]-[Number key] : Equivalent numpad key
# [Modifier]-[Backspace] : Del (for those wishing to perform Ctrl-Alt-Del, use Ctrl-Alt-Modifier-Backspace)
# [Modifier]-[PgDn] : Left Win/GUI key
# [Modifier]-[`] : Escape key
#

# Pin Layout
# ----------
#
# / => Dead pin, do not use
#
# Strobe:
#
#   /  PB0 PB1 PB2 PB3 PB4 PB5 PB6 PB7 PC0 PC1 PC2 PC3 PC4 PC5
# +-----------------------------------------------------------+
# | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11| 12| 13| 14|
# +-----------------------------------------------------------+
#
# Sense:
#
#  PF0 PF1 PF2 PF3 PF4 PF5 PF6 PF7  /   /   /   /   /   /   /
# +-----------------------------------------------------------+
# | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11| 12| 13| 14|
# +-----------------------------------------------------------+

# Physical Key Layout (non-standard keys referred to by keycap lettering)
# -------------------
# strobe  PB0   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   LMar         UNASSIGNED   UNASSIGNED   SPACE
# strobe  PB1   T Clr        T Set        Mar Rel      UNASSIGNED   TAB          RMar         CAPS_LOCK    X arrow
# strobe  PB2   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   RSHIFT       LSHIFT
# strobe  PB3   UNASSIGNED   A            o +-         1            Q            UNASSIGNED   Z            UNASSIGNED
# strobe  PB4   UNASSIGNED   S            UNASSIGNED   2            W            UNASSIGNED   X            UNASSIGNED
# strobe  PB5   UNASSIGNED   D            UNASSIGNED   3            E            UNASSIGNED   C            UNASSIGNED
# strobe  PB6   G            F            5            4            R            T            V            B
# strobe  PB7   H            J            6            7            U            Y            M            N
#
# strobe  PC0   UNASSIGNED   K            EQUAL        8            I            []           COMMA        UNASSIGNED
# strobe  PC1   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   Code
# strobe  PC2   DOWN         Reloc        Paper Up     UNASSIGNED   Paper Down   UNASSIGNED   UNASSIGNED   RIGHT
# strobe  PC3   ENTER        UNASSIGNED   BACKSPACE    UNASSIGNED   UNASSIGNED   UNASSIGNED   UP           LEFT
# strobe  PC4   QUOTE        SEMICOLON    MINUS        0            P            1/4 1/2      UNASSIGNED   SLASH
# strobe  PC5   UNASSIGNED   L            UNASSIGNED   9            O            UNASSIGNED   PERIOD       UNASSIGNED

matrix
   sense             PF0          PF1          PF2          PF3          PF4          PF5          PF6          PF7
   # ----------+------------+------------+------------+------------+------------+------------+------------+------------
   strobe  PB0   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   SPACE
   strobe  PB1   LCTRL        LGUI         ESC          UNASSIGNED   TAB          FN2          CAPS_LOCK    RCTRL
   strobe  PB2   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   RSHIFT       LSHIFT
   strobe  PB3   UNASSIGNED   A            BACK_QUOTE   1            Q            UNASSIGNED   Z            UNASSIGNED
   strobe  PB4   UNASSIGNED   S            UNASSIGNED   2            W            UNASSIGNED   X            UNASSIGNED
   strobe  PB5   UNASSIGNED   D            UNASSIGNED   3            E            UNASSIGNED   C            UNASSIGNED
   strobe  PB6   G            F            5            4            R            T            V            B
   strobe  PB7   H            J            6            7            U            Y            M            N
   
   strobe  PC0   UNASSIGNED   K            EQUAL        8            I            RIGHT_BRACE  COMMA        UNASSIGNED
   strobe  PC1   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   UNASSIGNED   LALT
   strobe  PC2   DOWN         BACKSLASH    PAGE_UP      UNASSIGNED   PAGE_DOWN    UNASSIGNED   UNASSIGNED   RIGHT
   strobe  PC3   ENTER        UNASSIGNED   BACKSPACE    UNASSIGNED   UNASSIGNED   UNASSIGNED   UP           LEFT
   strobe  PC4   QUOTE        SEMICOLON    MINUS        0            P            LEFT_BRACE   UNASSIGNED   SLASH
   strobe  PC5   UNASSIGNED   L            UNASSIGNED   9            O            UNASSIGNED   PERIOD       UNASSIGNED
end

# UNASSIGNED: LMar

macroblock

endblock

layerblock
   FN2 2
endblock
remapblock
   layer 2
   BACKSPACE   DELETE
   1           F1
   2           F2
   3           F3
   4           F4
   5           F5
   6           F6
   7           F7
   8           F8
   9           F9
   0           F10
   MINUS       F11
   EQUAL       F12
   PAGE_UP     INSERT
endblock
