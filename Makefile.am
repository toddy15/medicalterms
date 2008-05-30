# The Makefile for medicalterms
## Process this file with automake to produce Makefile.in
#
# Copyright (C) 2005-2008 Tobias Toedter <t.toedter@gmx.net>
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

SUBDIRS = bin dicts

CLEANFILES = german-medical \
	de_med.dic

export LISTS = \
	abkuerzungen-x-de_all-medicalterms.txt \
	adjektive-de_all-medicalterms.txt \
	ergaenzungen-xx-de_all-medicalterms.txt \
	medizin-xx-de_all-medicalterms.txt \
	namen-x-de_all-medicalterms.txt \
	verben-de_all-medicalterms.txt \
	wirkstoffe-x-de_all-medicalterms.txt


all-local: german-medical de_med.dic

install-data-local: install-german-medical install-de_med.dic

uninstall-local: uninstall-german-medical uninstall-de_med.dic


#####################################################################
# plain wordlist for installing in /usr/share/dict/
#####################################################################

# Generates a complete wordlist without TeX ligatures in ISO-8859-1 encoding
german-medical:
	$(srcdir)/bin/get_words $(addprefix $(srcdir)/dicts/, $(LISTS) $(ADDITIONAL_LISTS)) | \
	$(PERL) -pe 's/qq//g' | \
	$(SORT) -u | \
	$(ASPELL) expand --encoding=UTF-8 --lang=de | \
	$(PERL) -pe 's/ /\n/g' | \
	$(ASPELL) conv UTF-8 ISO-8859-1 | \
	LANG=de_DE $(SORT) -u > $@

.PHONY: install-german-medical
install-german-medical: german-medical
	$(INSTALL) --directory $(DESTDIR)$(datadir)/dict/
	$(INSTALL_DATA) german-medical $(DESTDIR)$(datadir)/dict/

.PHONY: uninstall-german-medical
uninstall-german-medical:
	rm -f $(DESTDIR)$(datadir)/dict/german-medical


#####################################################################
# hunspell
#####################################################################

de_med.dic:
	$(srcdir)/bin/get_words $(addprefix $(srcdir)/dicts/, $(LISTS) $(ADDITIONAL_LISTS)) | \
	$(PERL) -pe 's/qq//g' | \
	$(SORT) -u | \
	$(ASPELL) conv UTF-8 ISO-8859-1 | \
	LANG=de_DE $(SORT) -u > $@.tmp
	wc -l < $@.tmp > $@
	cat $@.tmp >> $@
	rm -f $@.tmp

.PHONY: install-de_med.dic
install-de_med.dic: de_med.dic
	$(INSTALL) --directory $(DESTDIR)$(datadir)/myspell/dicts
	$(INSTALL_DATA) de_med.dic $(DESTDIR)$(datadir)/myspell/dicts

.PHONY: uninstall-de_med.dic
uninstall-de_med.dic:
	rm -f $(DESTDIR)$(datadir)/myspell/dicts/de_med.dic


#####################################################################
# This is for creating a release tarball which is signed
#####################################################################

.PHONY: release
release: distcheck
	rm -f $(PACKAGE_TARNAME)-$(PACKAGE_VERSION).tar.gz.sig
	gpg --detach-sign $(PACKAGE_TARNAME)-$(PACKAGE_VERSION).tar.gz
