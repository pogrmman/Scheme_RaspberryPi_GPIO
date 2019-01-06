(define-library (raspberry-pi gpio setup)
  (import (scheme base))
  (include-c-header "<wiringPi.h>")

  (export gpio-setup!)

  (begin
    (define-c gpio-setup!
      "(void *data, int argc, closure _, object k)"
      "int succ = wiringPiSetup();
       if (succ == -1) {
         return_closcall1(data, k, boolean_f);
       }
       return_closcall1(data, k, boolean_t);
      ")))
