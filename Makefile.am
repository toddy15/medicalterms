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

CLEANFILES = german-medical \
	de-medical.rws

export LISTS = medizin.txt \
	medizin-verben-adjektive.txt \
	medizin-abkuerzungen.txt \
	medizin-ergaenzungen.txt \
	medizin-namen.txt


all-local: german-medical aspell

install-data-local: install-german-medical install-aspell

uninstall-local: uninstall-german-medical uninstall-aspell


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
	$(INSTALL_DATA) --owner=root --group=root \
		german-medical $(DESTDIR)$(datadir)/dict/

.PHONY: uninstall-german-medical
uninstall-german-medical:
	rm -f $(DESTDIR)$(datadir)/dict/german-medical


#####################################################################
# aspell
#####################################################################

aspell: german-medical
	$(ASPELL) --lang=de create master ./de-medical.rws < german-medical

.PHONY: install-aspell
install-aspell: aspell
	$(INSTALL) --directory $(DESTDIR)$(libdir)/aspell-0.60/
	$(INSTALL_DATA) --owner=root --group=root \
		de-medical.rws $(srcdir)/dicts/de-medical.multi \
		$(DESTDIR)$(libdir)/aspell-0.60/

.PHONY: uninstall-aspell
uninstall-aspell:
	rm -f $(DESTDIR)$(libdir)/aspell-0.60/de-medical.rws
	rm -f $(DESTDIR)$(libdir)/aspell-0.60/de-medical.multi


#####################################################################
# The ChangeLog should be in the tarball, but doesn't need to be
# under version control, because it's generated automatically.
#####################################################################

.PHONY: ChangeLog
ChangeLog:
	baz changelog > ChangeLog


#####################################################################
# This is for creating a release tarball which is signed
#####################################################################

.PHONY: release
release: distcheck
	rm -f $(PACKAGE_TARNAME)-$(PACKAGE_VERSION).tar.gz.sig
	gpg --detach-sign $(PACKAGE_TARNAME)-$(PACKAGE_VERSION).tar.gz
