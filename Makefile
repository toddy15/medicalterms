# The Makefile for medical terms
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

# define the paths to utilities
MAKE = /usr/bin/make
ISPELL = /usr/bin/ispell
ASPELL = /usr/bin/aspell
MYSPELL = /usr/bin/myspell
BUILDHASH = /usr/bin/buildhash
MUNCHLIST = /usr/bin/munchlist
GREP = /bin/grep
SORT = /bin/sort
PERL = /usr/bin/perl
ICONV = /usr/bin/iconv

# extract the library directory for ispell
ISPELL_LIBDIR = $$($(ISPELL) -vv | $(GREP) LIBDIR | $(PERL) -pe 's/.+?"(.+)"/\1/')


#####################################################################
# Targets needed for all spellcheckers
#####################################################################

# Generates a complete wordlist without TeX ligatures.
# The list still includes the suffixes for ispell.
wordlist-suffix:
	bin/get_words dicts/medizin*txt | \
	bin/utf_to_ispell - | \
	$(PERL) -pe 's/qq//g' | \
	$(SORT) -u > $@

wordlist-munch: wordlist-suffix german.aff
	$(MUNCHLIST) -l german.aff wordlist-suffix > $@

wordlist-hash: wordlist-munch
	$(BUILDHASH) wordlist-munch german.aff $@.hash

# Generates the plain wordlist in ISO-8859-1
wordlist: wordlist-hash
	cat wordlist-suffix | \
	$(ISPELL) -e -d ./wordlist-hash | \
	$(PERL) -pe 's/ /\n/g' | \
	bin/ispell_to_utf - | \
	$(ICONV) --from-code=UTF-8 --to-code=ISO-8859-1 - | \
	$(SORT) -u > $@

clean:
	rm -rf wordlist-* wordlist de-medical.rws \
	medicalterms-[0-9]*.tar.gz

dist:
	date +%Y%m%d > release-date
	baz export medicalterms-dev@gna.org/medicalterms--main--1.0 \
		medicalterms-`cat release-date`
	tar czf medicalterms-`cat release-date`.tar.gz \
		medicalterms-`cat release-date`
	rm -rf medicalterms-`cat release-date` release-date


#####################################################################
# ispell
#####################################################################

ispell:
	@echo Not yet implemented.


#####################################################################
# aspell
#####################################################################

aspell: wordlist
	$(ASPELL) --lang=de create master ./de-medical.rws < wordlist


#####################################################################
# myspell
#####################################################################

myspell:
	@echo Not yet implemented.
