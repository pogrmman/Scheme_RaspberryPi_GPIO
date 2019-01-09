;; Syntatic sugar for define-c to make it easier to use and understand
(define-syntax def-c
  (syntax-rules ()
    ((_ (name arg1 ...) body) 
     (define-c
       name
       (string-append "(void *data, int argc, closure _, object k"
		      (string-append ", object " arg1) ... ")")
       body))
    ((_ name body)
     (define-c
       name
       "(void *data, int argc, closure _, object k)"
       body))))
