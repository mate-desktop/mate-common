# MATE_COMPILE_WARNINGS
# Turn on many useful compiler warnings
# For now, only works on GCC
#
#   Copyright (C) 2011 Perberos <perberos@gmail.com>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.


AC_DEFUN([MATE_COMPILE_WARNINGS],[
    dnl ******************************
    dnl More compiler warnings
    dnl ******************************

    m4_ifndef([AX_CHECK_COMPILE_FLAG],[
        AC_MSG_ERROR([You need to install the autoconf-archive package.])
    ])

    m4_ifndef([AX_APPEND_FLAG],[
        AC_MSG_ERROR([You need to install the autoconf-archive package.])
    ])

    AC_ARG_ENABLE(compile-warnings,
                  AS_HELP_STRING([--enable-compile-warnings=@<:@no/minimum/yes/maximum/error@:>@],
                                 [Turn on compiler warnings]),,
                  [enable_compile_warnings="m4_default([$1],[yes])"])

    AC_LANG_PUSH([C])

    case "$enable_compile_warnings" in
    no)
	warning_flags=
	;;
    minimum)
	warning_flags="-Wall"
	;;
    yes)
	warning_flags="-Wall -Wmissing-prototypes"
	;;
    maximum|error)
	warning_flags="-Wall -Wmissing-prototypes -Wbad-function-cast -Wcast-align -Wextra -Wno-unused-parameter -Wformat-nonliteral -Wmissing-declarations -Wmissing-field-initializers -Wnested-externs -Wpointer-arith -Wredundant-decls -Wshadow -Wstrict-prototypes -Werror=format-security"
	if test "$enable_compile_warnings" = "error" ; then
	    warning_flags="$warning_flags -Werror"
	fi
	;;
    *)
	AC_MSG_ERROR(Unknown argument '$enable_compile_warnings' to --enable-compile-warnings)
	;;
    esac

    # Always pass -Werror=unknown-warning-option to get Clang to fail on bad
    # flags, otherwise they are always appended to the warn_cflags variable, and
    # Clang warns on them for every compilation unit.
    # If this is passed to GCC, it will explode, so the flag must be enabled
    # conditionally.
    AX_CHECK_COMPILE_FLAG([-Werror=unknown-warning-option],[
        compiler_flags_test="-Werror=unknown-warning-option"
    ],[
        compiler_flags_test=""
    ])

    for flag in $warning_flags; do
         AX_CHECK_COMPILE_FLAG([$flag], [AX_APPEND_FLAG([$flag], [WARN_CFLAGS])], [], [$compiler_flags_test], [])
    done

    AC_MSG_CHECKING(flags to pass to the C compiler $CC)
    AC_MSG_RESULT(${WARN_CFLAGS})

    AC_LANG_POP([C])
    AC_SUBST(WARN_CFLAGS)
])

dnl For C++, do basically the same thing.
AC_DEFUN([MATE_CXX_WARNINGS],[

    m4_ifndef([AX_CHECK_COMPILE_FLAG],[
        AC_MSG_ERROR([You need to install the autoconf-archive package.])
    ])

    m4_ifndef([AX_APPEND_FLAG],[
        AC_MSG_ERROR([You need to install the autoconf-archive package.])
    ])

    AC_ARG_ENABLE(cxx-warnings,
                  AS_HELP_STRING([--enable-cxx-warnings=@<:@no/minimum/yes/maximum/error@:>@],
                                 [Turn on compiler warnings.]),,
                  [enable_cxx_warnings="m4_default([$1],[yes])"])

    AC_LANG_PUSH([C++])

    case "$enable_cxx_warnings" in
    no)
	warning_flags=
	;;
    minimum)
	warning_flags="-Wall"
	;;
    yes)
        warning_flags="-Wall -Woverloaded-virtual"
	;;
    maximum|error)
        warning_flags="-Wall -Woverloaded-virtual -Wextra -Wshadow -Wformat-nonliteral -Werror=format-security -Wno-unused-parameter -Wpointer-arith -Wcast-align -Wmissing-declarations -Wredundant-decls"
	if test "$enable_compile_warnings" = "error" ; then
	    warning_flags="$warning_flags -Werror"
	fi
	;;
    *)
	AC_MSG_ERROR(Unknown argument '$enable_cxx_warnings' to --enable-cxx-warnings)
	;;
    esac

    # Always pass -Werror=unknown-warning-option to get Clang to fail on bad
    # flags, otherwise they are always appended to the warn_cflags variable, and
    # Clang warns on them for every compilation unit.
    # If this is passed to GCC, it will explode, so the flag must be enabled
    # conditionally.
    AX_CHECK_COMPILE_FLAG([-Werror=unknown-warning-option],[
        compiler_flags_test="-Werror=unknown-warning-option"
    ],[
        compiler_flags_test=""
    ])

    for flag in $warning_flags; do
         AX_CHECK_COMPILE_FLAG([$flag], [AX_APPEND_FLAG([$flag], [WARN_CXXFLAGS])], [], [$compiler_flags_test], [])
    done

    AC_MSG_CHECKING(what language compliance flags to pass to the C++ compiler)
    AC_MSG_RESULT(${WARN_CXXFLAGS})

    AC_LANG_POP([C++])
    AC_SUBST(WARN_CXXFLAGS)
])
