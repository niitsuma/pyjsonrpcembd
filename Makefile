
SHELL = /bin/sh

prefix      = /usr
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
#SRCTESTC = test/calltest.c

all:    libpyjsonrpcembd.so


libpyjsonrpcembd.so:	pyjsonrpcembd.cpp pyjsonrpcembd.h 
	$(CC)  $(SRC) -shared   -o libpyjsonrpcembd.so  -fPIC -Wall  -I/usr/include/python2.5 -lpython2.5 -lboost_python

	#$(CC)  $(SRC) -shared -Wl,-soname,libpyjsonrpcembd.so  -o libpyjsonrpcembd.so  -fPIC -Wall  -I/usr/include/python2.5 -lpython2.5 -lboost_python

#cc pyjsonrpcembd.cpp -shared -o libpyjsonrpcembd.so  -I/usr/include/python2.5 -lpython2.5 -lboost_python


install: all pyjsonrpcembd.h
	$(INSTALL) libpyjsonrpcembd.so $(libdir)  ; $(INSTALL) pyjsonrpcembd.h $(includedir) ; python setup.py install ; /sbin/ldconfig /usr/lib

uninstall:
	rm  $(libdir)/libpyjsonrpcembd.so ;rm   $(includedir)/pyjsonrpcembd.h

	#$(INSTALL) -U $(libdir)/libpyjsonrpcembd.so 



test:calltest
	LD_LIBRARY_PATH="." ./calltest ;\
	LD_LIBRARY_PATH="." gosh test/calltest.scm ; \
	LD_LIBRARY_PATH="." clisp test/calltest.lisp  
calltest:test/calltest.c pyjsonrpcembd.cpp pyjsonrpcembd.h   libpyjsonrpcembd.so
	$(CC) test/calltest.c -I/usr/include/python2.5 -lpython2.5 -lboost_python -L. -lpyjsonrpcembd -I.  -o calltest
										

	#$(CC) calltest.c pyjsonrpcembd.cpp -I/usr/include/python2.5 -lpython2.5 -lboost_python -L. -lpyjsonrpcembd -I. -Wall  -o calltest
