
SHELL = /bin/sh

prefix      = /usr/local
exec_prefix = ${prefix}
bindir      = ${exec_prefix}/bin
libdir      = ${exec_prefix}/lib
includedir  = ${exec_prefix}/include
datadir     = ${prefix}/share
datarootdir = @datarootdir@
srcdir      = .

CC = gcc
INSTALL = install

SRC = pyjsonrpcembd.cpp

all:  libpyjsonrpcembd.so test


libpyjsonrpcembd.so:	pyjsonrpcembd.cpp pyjsonrpcembd.h 
	$(CC)  $(SRC) -shared   -o libpyjsonrpcembd.so  -fPIC -Wall  -I/usr/include/python2.7 -lpython2.7 -lboost_python-2.7


install: all pyjsonrpcembd.h
	$(INSTALL) libpyjsonrpcembd.so $(libdir)  ; $(INSTALL) pyjsonrpcembd.h $(includedir) ; /sbin/ldconfig $(libdir)

uninstall:
	rm  $(libdir)/libpyjsonrpcembd.so ;rm   $(includedir)/pyjsonrpcembd.h


.PHONY: test

test:example/example-c libpyjsonrpcembd.so
	LD_LIBRARY_PATH="." ./example/example-c

#	racket ./example/example-racket.rkt
#	racket ./test/unit-test.rkt



example/example-c:example/example-c.c pyjsonrpcembd.cpp pyjsonrpcembd.h libpyjsonrpcembd.so
	$(CC) example/example-c.c -I/usr/include/python2.7 -lpython2.7 -lboost_python-2.7 -L. -lpyjsonrpcembd -I.  -o example/example-c



