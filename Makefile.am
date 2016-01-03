# The Makefile for medicalterms
## Process this file with automake to produce Makefile.in
#
# Copyright © 2005-2015 Dr. Tobias Quathamer <t.quathamer@mailbox.org>
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


PLAIN_LISTS = $(shell find dicts/ -name "*txt" ! -name "*-xx-*" ! -name "*-a-*")
COMPOUND_LISTS = $(shell find dicts/ -name "*txt" -name "*-xx-*")

all-local: german-medical de_med.dic

install-data-local: install-german-medical install-de_med.dic

uninstall-local: uninstall-german-medical uninstall-de_med.dic


#####################################################################
# plain wordlist for installing in /usr/share/dict/
#####################################################################

# Generates a complete wordlist without TeX ligatures in ISO-8859-1 encoding
german-medical: $(PLAIN_LISTS) $(COMPOUND_LISTS)
	$(srcdir)/bin/get_words $(PLAIN_LISTS) $(COMPOUND_LISTS) | \
	$(PERL) -pe 's/qq//g' | \
	$(SORT) -u | \
	$(ASPELL) expand --encoding=UTF-8 --lang=de | \
	$(PERL) -pe 's/ /\n/g' | \
	$(ASPELL) conv UTF-8 ISO-8859-1 | \
	LANG=de_DE LC_ALL=de_DE $(SORT) -u > $@

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

de_med.dic: $(PLAIN_LISTS) $(COMPOUND_LISTS)
# Get all plain list words
	$(srcdir)/bin/get_words $(PLAIN_LISTS) | \
	$(PERL) -pe 's/qq//g' | \
	$(SORT) -u > $@.plain.tmp
# Get all compoundable list words
	$(srcdir)/bin/get_words $(COMPOUND_LISTS) | \
	$(PERL) -pe 's/qq//g' | \
	$(PERL) -pe "if (/\//) {s,$$,m,} else {s,$$,/m,}" | \
	$(SORT) -u > $@.compound.tmp
# Add lowercase compoundable words
	$(srcdir)/bin/get_words $(COMPOUND_LISTS) | \
	$(PERL) -pe 's/qq//g' | \
	$(PERL) -ne 'tr/ÄÖÜ/äöü/; print lcfirst;' | \
	$(PERL) -pe "if (/\//) {s,$$,ozm,} else {s,$$,/ozm,}" | \
	$(SORT) -u > $@.compound.lower.tmp
# Create list for all words
	cat $@.plain.tmp $@.compound.tmp $@.compound.lower.tmp | \
	$(ASPELL) conv UTF-8 ISO-8859-1 | \
	LANG=de_DE LC_ALL=de_DE $(SORT) -u > $@.tmp
	wc -l < $@.tmp > $@
	cat $@.tmp >> $@
	rm -f $@.tmp $@.plain.tmp $@.compound.tmp $@.compound.lower.tmp

.PHONY: install-de_med.dic
install-de_med.dic: de_med.dic
	$(INSTALL) --directory $(DESTDIR)$(datadir)/hunspell
	$(INSTALL_DATA) de_med.dic $(DESTDIR)$(datadir)/hunspell

.PHONY: uninstall-de_med.dic
uninstall-de_med.dic:
	rm -f $(DESTDIR)$(datadir)/hunspell/de_med.dic


#####################################################################
# Create a tarball for igerman98 contrib directory
#####################################################################

.PHONY: igerman-contrib
igerman-contrib:
	mkdir $@
	mkdir $@/dicts
	cp $(srcdir)/dicts/*txt $@/dicts
	for wordlist in $@/dicts/*txt; do \
		$(srcdir)/bin/get_words $$wordlist > tmp; \
		$(srcdir)/bin/convert_to_igerman98 tmp > $$wordlist; \
		$(ASPELL) conv UTF-8 ISO-8859-1 < $$wordlist > tmp; \
		mv tmp $$wordlist; \
	done
	$(ASPELL) conv UTF-8 ISO-8859-1 < README.medicalterms \
		> $@/README.medicalterms
	cd $@ && tar czf $(PACKAGE_TARNAME)-igerman98-$(PACKAGE_VERSION).tar.gz *
	mv $@/$(PACKAGE_TARNAME)-igerman98-$(PACKAGE_VERSION).tar.gz .
	rm -rf $@


#####################################################################
# This is for creating a release tarball which is signed
#####################################################################

.PHONY: release
release: distcheck
	rm -f $(PACKAGE_TARNAME)-$(PACKAGE_VERSION).tar.gz.sig
	gpg --detach-sign $(PACKAGE_TARNAME)-$(PACKAGE_VERSION).tar.gz
