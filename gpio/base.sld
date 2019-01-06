(define-library (gpio base)
  (import (scheme base))
  (include-c-header "test.h")

  (export pin-mode write-pin read-pin)
  (begin
    (define-c c-pin-mode
      "(void *data, int argc, closure _, object k)"
      "
