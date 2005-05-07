# The Makefile for medicalterms
## Process this file with automake to produce Makefile.in
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

SUBDIRS = bin dicts

CLEANFILES = wordlist \
	de-medical.rws \
	ChangeLog

LISTS = medizin.txt \
	medizin-abkuerzungen.txt \
	medizin-ergaenzungen.txt \
	medizin-namen.txt


all-local: wordlist aspell

install-data-local: install-aspell


#####################################################################
# plain wordlist
#####################################################################

# Generates a complete wordlist without TeX ligatures in ISO-8859-1 encoding
wordlist:
	$(srcdir)/bin/get_words $(addprefix $(srcdir)/dicts/, $(LISTS) $(ADDITIONAL_LISTS)) | \
	$(PERL) -pe 's/qq//g' | \
	$(SORT) -u | \
	$(ASPELL) expand --encoding=UTF-8 --lang=de | \
	$(PERL) -pe 's/ /\n/g' | \
	$(ASPELL) conv UTF-8 ISO-8859-1 | \
	$(SORT) -u > $@


#####################################################################
# aspell
#####################################################################

aspell: wordlist
	$(ASPELL) --lang=de create master ./de-medical.rws < wordlist

install-aspell: aspell
	@if test "$(libdir)/aspell-0.60" != "$(ASPELL_DICTDIR_PATH)"; then \
		echo "*****************************************************************" ;\
		echo "WARNING: The installation path for the dictionary is not the same" ;\
		echo "         as the path returned from aspell's configuration." ;\
		echo ;\
		echo "Installing into: $(libdir)/aspell-0.60" ;\
		echo "Aspell returned: $(ASPELL_DICTDIR_PATH)" ;\
		echo "*****************************************************************" ;\
	fi
	$(INSTALL) --directory $(libdir)/aspell-0.60/
	$(INSTALL_DATA) de-medical.rws $(srcdir)/dicts/de-medical.multi \
		$(libdir)/aspell-0.60/


#####################################################################
# The ChangeLog should be in the tarball, but doesn't need to be
# under version control, because it's generated automatically.
#####################################################################

ChangeLog:
	baz changelog > ChangeLog

.PHONY: ChangeLog
