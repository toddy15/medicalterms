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
	de-medical.rws

LISTS = medizin.txt \
	medizin-abkuerzungen.txt \
	medizin-ergaenzungen.txt \
	medizin-namen.txt


#####################################################################
# plain wordlist
#####################################################################

# Generates a complete wordlist without TeX ligatures in ISO-8859-1 encoding
wordlist:
	bin/get_words $(addprefix dicts/, $(LISTS) $(ADDITIONAL_LISTS)) | \
	bin/utf_to_ispell - | \
	$(PERL) -pe 's/qq//g' | \
	$(SORT) -u > temporary-suffix-list

	$(MUNCHLIST) -l german.aff temporary-suffix-list > temporary-munch-list

	$(BUILDHASH) temporary-munch-list german.aff temporary-hash.hash

	cat temporary-suffix-list | \
	$(ISPELL) -e -d ./temporary-hash | \
	$(PERL) -pe 's/ /\n/g' | \
	bin/ispell_to_utf - | \
	$(ICONV) --from-code=UTF-8 --to-code=ISO-8859-1 - | \
	$(SORT) -u > $@

	rm -f temporary-suffix-list temporary-munch-list* temporary-hash.hash


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
