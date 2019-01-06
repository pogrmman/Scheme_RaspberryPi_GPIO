(define-library (raspberry-pi gpio timing)
  (import (scheme base))
  (include-c-header "<wiringPi.h>")

  (export wait us-wait)

  (begin
    (define-c wait
      "(void *data, int argc, closure _, object k, object time)"
      " delay((unsigned int) (unbox_number(time)));
        return_closcall1(data, k, boolean_t);
      ")

    (define-c us-wait
      "(void *data, int argc, closure _, object k, object time)"
      " delayMicroseconds((unsigned int) (unbox_number(time)));
        return_closcall1(data, k, boolean_t);
      "))) 
