README for medicalterms
=======================

The goal of this package is to create specialized dictionaries for medical
terms used in various languages. Those dictionaries can be used easily with
hunspell, an advanced spellchecker.

As of now, German is the only supported language. If you'd like to contribute
to the development of the package medicalterms, please contact me. You can
find the latest version on <https://github.com/toddy15/medicalterms>.

The dictionary supports old and new spelling variants. Currently, however,
only the new variant is generated for hunspell. There's currently no
configuration option to use the old orthography or both variants
simultaneously.


How to use the new dictionary with hunspell
===========================================

Assume that you have checked your files this way:

$ hunspell -d de_DE myfile.txt

You only need to add the new dictionary to the command line to get rid of
all the warnings about unknown medical terms:

$ hunspell -d de_DE,de_med myfile.txt

Please note that this requires hunspell 1.2.2 or later.


Access to the source code repository
====================================

This project is hosted on github:

https://github.com/toddy15/medicalterms

Please send your patches and pull requests to me.

 -- Dr. Tobias Quathamer <t.quathamer@mailbox.org>  Thu, 10 Dec 2015 14:02:06 +0100
