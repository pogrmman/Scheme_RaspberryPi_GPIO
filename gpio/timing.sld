(define-library (raspberry-pi gpio timing)
  (import (scheme base))
  (include-c-header "<wiringPi.h>")

  (export wait)

  (begin
    (define-c wait
      "(void *data, int argc, closure _, object k, object time)"
      " delay((unsigned int) (unbox_number(time)));
        return_closcall1(data, k, boolean_t);
      ")))
