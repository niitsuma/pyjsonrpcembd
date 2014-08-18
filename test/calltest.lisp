(asdf:oos 'asdf:load-op :cffi)
;(require :cffi)
(cffi::define-foreign-library libpyjsonrpcembd
  (:unix "libpyjsonrpcembd.so")
  (:windows "libpyjsonrpcembd.dll"))
(cffi::load-foreign-library 'libpyjsonrpcembd)
(cffi::defcfun ("pyjsonrpcembdinit"     pyjsonrpcembdinit) :void )
(cffi::defcfun ("pyjsonrpcembdfinalize" pyjsonrpcembdfinalize) :void )
(cffi::defcfun ("pyjsonrpcembdhandle"   pyjsonrpcembdhandle) :string (jsonstr :string) )



(pyjsonrpcembdinit)

(print "inlisp")

(print 
(pyjsonrpcembdhandle 
"{\"jsonrpc\": \"2.0\", \"method\": \"norm\", \"params\": [[2, 3]], \"id\": 0}"))


(print 
(pyjsonrpcembdhandle 
"{\"jsonrpc\": \"2.0\", \"method\": \"echo\", \"params\": [\"aaa\"], \"id\": 0}"))


(pyjsonrpcembdfinalize)