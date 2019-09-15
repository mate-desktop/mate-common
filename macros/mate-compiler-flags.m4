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
	warning_flags="-Wall -Wmissing-prototypes -Wbad-function-cast -Wcast-align -Wextra -Wformat-nonliteral -Wmissing-declarations -Wmissing-field-initializers -Wnested-externs -Wpointer-arith -Wredundant-decls -Wshadow -Wstrict-prototypes -Werror=format-security -Wno-sign-compare"
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
  AC_ARG_ENABLE(cxx-warnings,
                AS_HELP_STRING([--enable-cxx-warnings=@<:@no/minimum/yes@:>@]
                               [Turn on compiler warnings.]),,
                [enable_cxx_warnings="m4_default([$1],[minimum])"])

  AC_MSG_CHECKING(what warning flags to pass to the C++ compiler)
  warnCXXFLAGS=
  if test "x$GXX" != xyes; then
    enable_cxx_warnings=no
  fi
  if test "x$enable_cxx_warnings" != "xno"; then
    if test "x$GXX" = "xyes"; then
      case " $CXXFLAGS " in
      *[\ \	]-Wall[\ \	]*) ;;
      *) warnCXXFLAGS="-Wall -Wno-unused" ;;
      esac

      ## -W is not all that useful.  And it cannot be controlled
      ## with individual -Wno-xxx flags, unlike -Wall
      if test "x$enable_cxx_warnings" = "xyes"; then
	warnCXXFLAGS="$warnCXXFLAGS -Wshadow -Woverloaded-virtual"
      fi
    fi
  fi
  AC_MSG_RESULT($warnCXXFLAGS)

   AC_ARG_ENABLE(iso-cxx,
                 AS_HELP_STRING([--enable-iso-cxx],
                                [Try to warn if code is not ISO C++ ]),,
                 [enable_iso_cxx=no])

   AC_MSG_CHECKING(what language compliance flags to pass to the C++ compiler)
   complCXXFLAGS=
   if test "x$enable_iso_cxx" != "xno"; then
     if test "x$GXX" = "xyes"; then
      case " $CXXFLAGS " in
      *[\ \	]-ansi[\ \	]*) ;;
      *) complCXXFLAGS="$complCXXFLAGS -ansi" ;;
      esac

      case " $CXXFLAGS " in
      *[\ \	]-pedantic[\ \	]*) ;;
      *) complCXXFLAGS="$complCXXFLAGS -pedantic" ;;
      esac
     fi
   fi
  AC_MSG_RESULT($complCXXFLAGS)

  WARN_CXXFLAGS="$CXXFLAGS $warnCXXFLAGS $complCXXFLAGS"
  AC_SUBST(WARN_CXXFLAGS)
])
