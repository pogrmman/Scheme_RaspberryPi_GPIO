(define-library (raspberry-pi gpio pins)
  (import (scheme base))
  (include-c-header "<wiringPi.h>")

  (export pin-mode write-pin read-pin INPUT OUTPUT PWM_OUTPUT)

  (begin
    (define-c pin-mode
      "(void *data, int argc, closure _, object k, object pin, object mode)"
      "int int_mode = (int) (unbox_number(mode));
       int int_pin = (int) (unbox_number(pin));
       if(int_mode == 0) {
         pinMode(int_pin, OUTPUT);
       } else if(int_mode==1) {
         pinMode(int_pin, INPUT);
       } else if(int_mode==2) {
         pinMode(int_pin, PWM_OUTPUT);
       } else {
         return_closcall1(data, k, boolean_f);
       return_closcall1(data, k, pin);")

    (define-c write-pin
      "(void *data, int argc, closure _, object k, object pin, object val)"
      "digitalWrite((int) (unbox_number(pin)), (int) (unbox_number(val)));
       return_closcall1(data, k, boolean_t);")

    (define-c read-pin
      "(void *data, int argc, closure _, object k, object pin)"
      "int reading = digitalRead((int) (unbox_number(pin)));
       return_closcall1(data, k, obj_obj2int(reading));")

    (define OUTPUT 0)
    (define INPUT 1)
    (define PWM_OUTPUT 2)))
