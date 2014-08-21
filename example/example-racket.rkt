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

(define (py func args)
  (string->jsexpr 
   (pyjson
    (jsexpr->string 
     (make-hash 
      (list (cons 'method  func) (cons 'params  args )))))))


(define pystrexec
    (get-ffi-obj "PyRun_SimpleString" 
                 "libpyjsonrpcembd"
                 (_fun _string -> _int)
      (lambda ()
        (error 'libpyjsonrpcembd
               "installed libpyjsonrpcembd does not provide \"exec\""))))

(define pystr2json
    (get-ffi-obj "pyjsonrpcembdstreval" 
                 "libpyjsonrpcembd"
                 (_fun _string -> _string)
      (lambda ()
        (error 'libpyjsonrpcembd
               "installed libpyjsonrpcembd does not provide \"eval\""))))
(define (pystr expr) (string->jsexpr (pystr2json expr)))

;;;=================init end====================

(pyinit)

(pystr "str(3*4)")
(pystrexec "print(3*4)")


(pystrexec "import numpy")
(pystr "numpy.linalg.norm([1,2])") ;;=> 2.2360679774997898
(py "numpy.linalg.norm"  '((1 2))) ;;=> 2.2360679774997898

(pystrexec "print(numpy.array([3,4]))")

(pystr "3*4") ;;=>12


(py "range" '(2 6)) ;; =>'(2 3 4 5)

(string->jsexpr 
 (pyjson "{\"method\": \"range\", \"params\": [2,6]}"))  ;; =>'(2 3 4 5)

(string->jsexpr 
 (pyjson 
  (jsexpr->string 
   (make-hash '
    ((method . "range") ( params . (2 6))))))) ;;=> '(2 3 4 5)

(pystr "_") ;;=> '(2 3 4 5)



(string->jsexpr 
 (pyjson "{\"method\": \"min\", \"params\": [[9, 3 , 7]]}")) ;;=> 3 

(pystrexec "x=[3,4]")
(pystr "x*2") ;;=> '(3 4 3 4)


(pystrexec "import sys")
;(pystr "sys.last_value") ;;error

(pystrexec "import nltk")
