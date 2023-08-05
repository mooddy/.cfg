/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Iosevka NF Medium:size=11"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#00ffff", "#eeeeee" },
	[SchemeSel] = { "#000000", "#0ECC75"},
	[SchemeSelHighlight] = { "#ffffff", "#0ECC75" },
 	[SchemeNormHighlight] = { "#00ffff", "#343a3f" },	
	[SchemeOut] = { "#00ffff", "#00ffff" },
	[SchemeMid] = { "#00ffff", "#343a3f" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0 ;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static const unsigned int border_width = 1;
