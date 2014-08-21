#lang racket
 (require ffi/unsafe)
 (require json)

(ffi-lib "/usr/local/lib/libpyjsonrpcembd")

(define pyinit
    (get-ffi-obj "pyjsonrpcembdinit"
                 "libpyjsonrpcembd"
                 (_fun  -> _void)
      (lambda ()
        (error 'libpyjsonrpcembd
               "installed libpyjsonrpcembd does not provide \"init\""))))

(define pyjson
    (get-ffi-obj "pyjsonrpcembdhandle"
                 "libpyjsonrpcembd"
                 (_fun  _string -> _string)
      (lambda ()
        (error 'libpyjsonrpcembd
               "installed libpyjsonrpcembd does not provide \"json\""))))

(define pystrexec
    (get-ffi-obj "PyRun_SimpleString" 
                 "libpyjsonrpcembd"
                 (_fun _string -> _int)
      (lambda ()
        (error 'libpyjsonrpcembd
               "installed libpyjsonrpcembd does not provide \"exec\""))))

(define pystr
    (get-ffi-obj "pyjsonrpcembdstreval" 
                 "libpyjsonrpcembd"
                 (_fun _string -> _string)
      (lambda ()
        (error 'libpyjsonrpcembd
               "installed libpyjsonrpcembd does not provide \"eval\""))))

;;;=================init end====================

(pyinit)

(pystr "str(3*4)")
(pystrexec "print(3*4)")
(pystrexec "import nltk")
(pystrexec "import numpy")
(pystrexec "print(numpy.array([3,4]))")

(pystr "3*4")

(string->jsexpr 
 (pyjson "{\"method\": \"min\", \"params\": [[9, 3 , 7]]}")) ;;=> 3 
(string->jsexpr 
 (pyjson "{\"method\": \"range\", \"params\": [2,6]}"))  ;; =>'(2 3 4 5)
(string->jsexpr 
 (pyjson 
  (jsexpr->string 
   (make-hash '
    ((method . "range") ( params . (2 6))))))) ;;=> '(2 3 4 5)
(pystr "_") ;"[2, 3, 4, 5]"

(pystrexec "x=[3,4]")
(string->jsexpr (pystr "x*2"))





