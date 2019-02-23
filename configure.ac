AC_PREREQ(2.54)
AC_INIT([mate-common], [1.22.0], [https://github.com/mate-desktop/mate-common])

AC_CONFIG_SRCDIR([macros/mate-autogen])

AM_INIT_AUTOMAKE([1.9 foreign no-dist-gzip dist-xz check-news])

m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([no])])

if test -z "$enable_maintainer_mode"; then
    enable_maintainer_mode=yes
fi

AM_MAINTAINER_MODE([enable])

AC_CONFIG_FILES([
Makefile
macros/Makefile
doc-build/Makefile
doc-build/mate-doc-common
doc/Makefile
])

AC_OUTPUT
