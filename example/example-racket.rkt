#lang racket

(require "python-on-racket.rkt")
(require json)
;;;=================init end====================

(pyinit)

(pystr "3*4") ;;=>12
(pystr "str(3*4)") ;;=>"12"
(pystrexec "print(3*4)")

(pystrexec "import numpy")
(pystr "numpy.linalg.norm([1,2])") ;;=> 2.2360679774997898
(py "numpy.linalg.norm"  '((1 2))) ;;=> 2.2360679774997898

(pystrexec "print(numpy.array([3,4]))")


(pystrexec "x=[3,4]")
(pystr "x*2") ;;=> '(3 4 3 4)
(pystrexec (format "x=json.loads('~a')" (jsexpr->string '(3 4))))
(pystr "x*2") ;;=> '(3 4 3 4)


(pystr "range(2,6)") ;; =>'(2 3 4 5)
(py "range" '(2 6))  ;; =>'(2 3 4 5)
(pystr (format "apply(range,json.loads('~a'))" (jsexpr->string '(2 6)))) ;;=> '(2 3 4 5)
(pyjson (method-params->json-str "range" '(2 6))) ;;=> '(2 3 4 5)
(pyjson "{\"method\": \"range\", \"params\": [2,6]}")  ;; =>'(2 3 4 5)

(string->jsexpr 
 (pyjson->json 
  (jsexpr->string 
   (make-hash
    '((method . "range") ( params . (2 6))))))) ;;=> '(2 3 4 5)

(pystr "_") ;;=> '(2 3 4 5) ;; _ = last_value


(pyjson "{\"method\": \"min\", \"params\": [[9,3,7]]}") ;;=> 3 


(pyfinalize)
