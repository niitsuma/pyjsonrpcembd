#lang racket

(provide (all-defined-out))

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

(define pyfinalize
    (get-ffi-obj "pyjsonrpcembdfinalize"
                 "libpyjsonrpcembd"
                 (_fun  -> _void)
      (lambda ()
        (error 'libpyjsonrpcembd
               "installed libpyjsonrpcembd does not provide \"finalize\""))))

(define pystr->json
    (get-ffi-obj "pyjsonrpcembdstreval" 
                 "libpyjsonrpcembd"
                 (_fun _string -> _string)
      (lambda ()
        (error 'libpyjsonrpcembd
               "installed libpyjsonrpcembd does not provide \"eval\""))))
(define (pystr expr) (string->jsexpr (pystr->json expr)))


(define pyjson->json
    (get-ffi-obj "pyjsonrpcembdhandle"
                 "libpyjsonrpcembd"
                 (_fun  _string -> _string)
      (lambda ()
        (error 'libpyjsonrpcembd
               "installed libpyjsonrpcembd does not provide \"json\""))))
(define (pyjson json-str) (string->jsexpr (pyjson->json json-str)))

(define (method-params->json-str func args)
  (jsexpr->string 
     (make-hash 
      (list (cons 'method  func) (cons 'params  args )))))

(define (py func args) (pyjson (method-params->json-str func args)))


(define pystrexec
    (get-ffi-obj "PyRun_SimpleString" 
                 "libpyjsonrpcembd"
                 (_fun _string -> _int)
      (lambda ()
        (error 'libpyjsonrpcembd
               "installed libpyjsonrpcembd does not provide \"exec\""))))
