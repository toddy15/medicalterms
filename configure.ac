# Some configure options for medicalterms
# Process this file with autoconf to produce a configure script.
#
# Copyright (C) 2005 Tobias Toedter <t.toedter@gmx.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

AC_INIT(medicalterms, esyscmd(date +%Y%m%d | perl -pe "chop"))
AM_INIT_AUTOMAKE(foreign)

# Enable the selection of different orthographies
ADDITIONAL_LISTS=medizin-n.txt
AC_ARG_ENABLE(orthography,
	AS_HELP_STRING([--enable-orthography=new],
	[specify the orthography (valid values are 'old', 'new', and 'both'. Defaults to 'new')]),
	[ac_cv_use_orthography=$enableval],
	[ac_cv_use_orthography=new])
if test "$ac_cv_use_orthography" = old; then
	ADDITIONAL_LISTS=medizin-a.txt
fi
if test "$ac_cv_use_orthography" = both; then
	ADDITIONAL_LISTS="medizin-n.txt medizin-a.txt"
fi
AC_SUBST(ADDITIONAL_LISTS)

# Check for needed programs
AC_PROG_EGREP
AC_PATH_PROG([PERL], [perl])
AC_PATH_PROG([SORT], [sort])

AC_PATH_PROG([ICONV], [iconv])
# Fail if program is not found
if test -z $ICONV; then
	AC_MSG_ERROR([iconv is required for installing this package.])
fi

AC_PATH_PROG([ISPELL], [ispell])
# Fail if program is not found
if test -z $ISPELL; then
	AC_MSG_ERROR([ispell is required for installing this package.])
fi

AC_PATH_PROG([BUILDHASH], [buildhash])
# Fail if program is not found
if test -z $BUILDHASH; then
	AC_MSG_ERROR([buildhash (part of ispell) is required for installing this package.])
fi

AC_PATH_PROG([MUNCHLIST], [munchlist])
# Fail if program is not found
if test -z $MUNCHLIST; then
	AC_MSG_ERROR([munchlist (part of ispell) is required for installing this package.])
fi

AC_PATH_PROG([ASPELL], [aspell])
AC_PATH_PROG([MYSPELL], [myspell])

# Specify the Makefiles
AC_CONFIG_FILES(Makefile bin/Makefile dicts/Makefile)

# Write the configure script
AC_OUTPUT
