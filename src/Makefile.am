# Makefile.am for Bitnion Core - adapted from Bitcoin Core

bin_PROGRAMS = bitniond bitnion-cli

bitniond_SOURCES = bitcoind.cpp
bitniond_LDADD = libbitcoin_server.a libbitcoin_util.a -lboost_system -lboost_filesystem

bitnion_cli_SOURCES = bitcoin-cli.cpp
bitnion_cli_LDADD = libbitcoin_util.a -lboost_system -lboost_filesystem

noinst_HEADERS = fs.h optional.h

SUBDIRS = interfaces node policy crypto util consensus
