#lang racket

; usage this file
; 1. install pyjsonrpcembd
; 2. locate  example-racket.rkt  python-on-racket.rkt same directory
; 3. $ racket example-racket.rkt

(require "python-on-racket.rkt")
(require json)
;;;=================init end====================

(pyinit)

(pystr "3*4") ;;=>12
(pystr "str(3*4)") ;;=>"12"
(pystrexec "print(3*4)")

(pystr "sorted([5,2,4,3])") ;; =>'(2 3 4 5)
(py "sorted" '((5 2 4 3)))  ;; =>'(2 3 4 5)
(pyjson "{\"method\": \"sorted\", \"params\": [[5,2,4,3]]}")
(pyjson (method-params->json-str "sorted" '((5 2 4 3))))

(pystrexec "import numpy")
(pystr "numpy.linalg.norm([1,2])") ;;=> 2.2360679774997898
(py "numpy.linalg.norm"  '((1 2))) ;;=> 2.2360679774997898

(pystrexec "x=[3,4]")
(pystr "x*2") ;;=> '(3 4 3 4)
(pystrexec (format "x=json.loads('~a')" (jsexpr->string '(3 4))))
(pystr "x*2") ;;=> '(3 4 3 4)

(pystr "round(1.2345,2)");;=>1.23
(py "round" '(1.2345 2));;=>1.23
(pystr (format "apply(round,json.loads('~a'))" (jsexpr->string '(1.2345 2)))) ;;=>1.23
(pyjson (method-params->json-str "round" '(1.2345 2))) ;;=>1.23
(pyjson "{\"method\": \"round\", \"params\": [1.2345,2]}")  ;;=>1.23

(string->jsexpr 
 (pyjson->json 
  (jsexpr->string 
   (make-hash
    '((method . "round") ( params . (1.2345 2))))))) ;;=>1.23

(pystr "_") ;;=>1.23 ;; _ = last_value


;(pyfinalize)
;;; bug python3 http://stackoverflow.com/questions/8798905/does-the-python-3-interpreter-leak-memory-when-embedded
;;; but pyfinalize works with python2.7
