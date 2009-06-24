/* See LICENSE file for copyright and license details. */
 
 
/* appearance */
/*static const char font[] = "-adobe-helvetica-medium-r-*-*-10-*-*-*-*-*-iso8859-*";*/
/*static const char font[] = "-artwiz-snap-normal-*-*-*-10-*-*-*-*-*-iso8859-*";*/
static const char font [] = "-artwiz-cure-medium-*-*-*-11-*-*-*-*-*-iso8859-*";
static const char normbordercolor[] = "#554444";
static const char normbgcolor[] = "#3d352a";
static const char normfgcolor[] = "#ddccaa";
static const char selbordercolor[] = "#ea6868";
static const char selbgcolor[] = "#3d352a";
static const char selfgcolor[] = "#afd700";
static unsigned int borderpx = 1; /* border pixel of windows */
static unsigned int snap = 12; /* snap pixel */
static Bool showbar = True; /* False means no bar */
static Bool topbar = True; /* False means bottom bar */
static Bool readin = True; /* False means do not read stdin */
static Bool usegrab = False; /* True means grabbing the X server
                                                   during mouse-based resizals */
 
 
/* tagging */
static const char tags[][MAXTAGLEN] = { "main", "code", "www", "sim", "music" };
static unsigned int tagset[] = {1, 1}; /* after start, first tag is selected */
 
static Rule rules[] = {
  /* class instance title tags mask isfloating */
  { "Gimp", NULL, NULL, 0, True },
/*  { "Firefox", NULL, NULL, 1 << 2, True }, */
    { "MPlayer", NULL, NULL, 1 << 8, True },
    { "xine", NULL, NULL, 1 << 8, True },
    { "PyBurn", NULL, NULL, 1 << 4, True },
};
 
/* layout(s) */
 
static float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static Bool resizehints = True; /* False means respect size hints in tiled resizals */
 
/* #include "grid.c" */
/* #include <tileh.c> */
static Layout layouts[] = {
  /* symbol arrange function */
  /*  { "+++", grid },  */
    { "[]=", tile }, /* first entry is default */
    { "><>", NULL }, /* no layout function means floating behavior */
    { "[M]", monocle }
};
 
/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
  { MODKEY, KEY, view, {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask, KEY, toggleview, {.ui = 1 << TAG} }, \
  { MODKEY|ShiftMask, KEY, tag, {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask|ShiftMask, KEY, toggletag, {.ui = 1 << TAG} },
 
/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
 
/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[] = { "urxvt", NULL };
 
static Key keys[] = {
  /* modifier key function argument */
  { MODKEY, XK_d, spawn, {.v = dmenucmd } },
  { MODKEY, XK_t, spawn, {.v = termcmd } },
  { MODKEY, XK_b, togglebar, {0} },
  { MODKEY, XK_j, focusstack, {.i = +1 } },
  { MODKEY, XK_k, focusstack, {.i = -1 } },
  { MODKEY, XK_h, setmfact, {.f = -0.05} },
  { MODKEY, XK_l, setmfact, {.f = +0.05} },
  { MODKEY, XK_Return, zoom, {0} },
  { MODKEY, XK_Tab, view, {0} },
  { MODKEY|ShiftMask, XK_c, killclient, {0} },
  { MODKEY|ShiftMask, XK_t, setlayout, {.v = &layouts[1]} },
  { MODKEY|ShiftMask, XK_f, setlayout, {.v = &layouts[2]} },
  { MODKEY|ShiftMask, XK_m, setlayout, {.v = &layouts[3]} },
  { MODKEY, XK_space, setlayout, {0} },
  { MODKEY|ShiftMask, XK_space, togglefloating, {0} },
  { MODKEY, XK_0, view, {.ui = ~0 } },
  { MODKEY|ShiftMask, XK_0, tag, {.ui = ~0 } },
  TAGKEYS( XK_1, 0)
  TAGKEYS( XK_2, 1)
  TAGKEYS( XK_3, 2)
  TAGKEYS( XK_4, 3)
  TAGKEYS( XK_5, 4)
  TAGKEYS( XK_6, 5)
  TAGKEYS( XK_7, 6)
  TAGKEYS( XK_8, 7)
  TAGKEYS( XK_9, 8)
  { MODKEY|ShiftMask, XK_q, quit, {0} },
};
 
/* button definitions */
/* click can be a tag number (starting at 0),
 * ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
  /* click event mask button function argument */
  { ClkLtSymbol, 0, Button1, setlayout, {0} },
  { ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]} },
  { ClkWinTitle, 0, Button2, zoom, {0} },
  { ClkStatusText, 0, Button2, spawn, {.v = termcmd } },
  { ClkClientWin, MODKEY, Button1, movemouse, {0} },
  { ClkClientWin, MODKEY, Button2, togglefloating, {0} },
  { ClkClientWin, MODKEY, Button3, resizemouse, {0} },
  { ClkTagBar, 0, Button1, view, {0} },
  { ClkTagBar, 0, Button3, toggleview, {0} },
  { ClkTagBar, MODKEY, Button1, tag, {0} },
  { ClkTagBar, MODKEY, Button3, toggletag, {0} },
};

