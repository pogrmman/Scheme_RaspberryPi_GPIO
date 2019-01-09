;; Pin mode function
(def-c (pin-mode! "pin" "mode")
      " int int_mode = (int) (unbox_number(mode));
        int int_pin = (int) (unbox_number(pin));
        if(int_mode == 0) {
          pinMode(int_pin, OUTPUT);
        } else if(int_mode==1) {
          pinMode(int_pin, INPUT);
        } else if(int_mode==2) {
          pinMode(int_pin, PWM_OUTPUT);
        } else {
          return_closcall1(data, k, boolean_f);
        }
        return_closcall1(data, k, pin);
      ")

;; Pin mode aliases
(define OUTPUT 0)
(define INPUT 1)
(define PWM_OUTPUT 2)
