#lang racket

(require ffi/unsafe)
(ffi-lib "/usr/lib64/libpython2.7")



(define pyinit
    (get-ffi-obj "Py_Initialize" 
                 "libpython2.7"

                 (_fun  -> _void)
      (lambda ()
        (error 'foolib
               "installed foolib does not provide \"init\""))))

(define pyeval
    (get-ffi-obj "PyRun_SimpleString" 
                 "libpython2.7"

                 (_fun _string -> _void)
      (lambda ()
        (error 'foolib
               "installed foolib does not provide \"eval\""))))


(pyinit)

(pyeval "str(3*4)")
(pyeval "print(3*4)")
(pyeval "import nltk")
(pyeval "import numpy")
(pyeval "print(numpy.array([3,4]))")




