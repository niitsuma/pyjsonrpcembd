#lang racket

(require (prefix-in schemeunit: rackunit))
(require (prefix-in schemeunit: rackunit/text-ui))

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

(define common-tests
  (schemeunit:test-suite
   "Base Tests "

   (pyinit)

   (schemeunit:check-equal? 
    (pystr "str(3*4)")
    "\"12\""
     )

   (schemeunit:check-equal? 
    (string->jsexpr (pyjson "{\"method\": \"min\", \"params\": [[9, 3 , 7]]}"))
    3)

   (schemeunit:check-equal? 
    (string->jsexpr (pyjson "{\"method\": \"range\", \"params\": [2,6]}"))
    (list 2 3 4 5)) 

   (pystrexec "x=[3,4]")
   (schemeunit:check-equal? 
    (string->jsexpr (pystr "x*2"))
    (list 3 4 3 4))
))

(schemeunit:run-tests common-tests)


;; (pystrexec "print(3*4)")
;; (pystrexec "import nltk")
;; (pystrexec "import numpy")
;; (pystrexec "print(numpy.array([3,4]))")





