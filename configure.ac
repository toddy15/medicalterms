# Some configure options for medicalterms
# Process this file with autoconf to produce a configure script.
#
# Copyright © 2005-2010 Tobias Quathamer <t.quathamer@gmx.net>
#
# This file is part of Medicalterms.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

AC_INIT(medicalterms, 20100204)
AM_MAINTAINER_MODE
AM_INIT_AUTOMAKE([foreign])

# Check for needed programs
AC_PATH_PROG([PERL], [perl])
if test -z $PERL; then
	AC_MSG_ERROR([perl is required for building this package.])
fi

AC_PATH_PROG([SORT], [sort])
if test -z $SORT; then
	AC_MSG_ERROR([sort is required for building this package.])
fi

AC_PATH_PROG([ASPELL], [aspell])
# Fail if program is not found
if test -z $ASPELL; then
	AC_MSG_ERROR([aspell is required for building this package.])
else
	AC_MSG_CHECKING([for aspell version >= 0.60.0])
	ac_cv_aspell_version=`$ASPELL --version | $PERL -pe "s/.+ really Aspell (.+)\)/\1/g"`
	changequote(+)dnl
	ac_cv_aspell_major=`$PERL -e "split /\./, '$ac_cv_aspell_version'; print @_[0]"`
	ac_cv_aspell_minor=`$PERL -e "split /\./, '$ac_cv_aspell_version'; print @_[1]"`
	changequote([, ])dnl
	if test $ac_cv_aspell_major -gt 0; then
		AC_MSG_RESULT([ok, found $ac_cv_aspell_version])
	else
		if test $ac_cv_aspell_minor -ge 60; then
			AC_MSG_RESULT([ok, found $ac_cv_aspell_version])
		else
			AC_MSG_RESULT([found $ac_cv_aspell_version])
			AC_MSG_ERROR([you need at least version 0.60.0 of aspell.])
		fi
	fi
fi


# Specify the Makefiles
AC_CONFIG_FILES(Makefile bin/Makefile dicts/Makefile)


# Write the configure script
AC_OUTPUT
