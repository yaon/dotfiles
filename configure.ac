AC_INIT([42sh], [1.0], [], [nguye_l-42sh])

AC_CONFIG_AUX_DIR([build-aux])

AM_INIT_AUTOMAKE([subdir-objects foreign -Wall dist-bzip2 no-dist-gzip])

CFLAGS="-Wall -Wextra -Werror -std=c99 -pedantic"
LDFLAGS="-ltermcap"

AC_PROG_CC
AM_PROG_CC_C_O

AC_ARG_WITH([debug],
            [AS_HELP_STRING([--with-debug], [add debug CFLAGS])])
[if test x$with_debug = xyes; then
 CFLAGS="$CFLAGS -g"
 fi]

AC_ARG_WITH([gdb],
            [AS_HELP_STRING([--with-gdb], [add debug CFLAGS])])
[if test x$with_gdb = xyes; then
 CFLAGS="$CFLAGS -g -ggdb3"
 fi]

AC_CONFIG_FILES([Makefile])
#AC_CONFIG_FILES([test_file], [])

AC_OUTPUT

