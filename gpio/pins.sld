;; Copyright 2019 Alexander Mohn
;;
;;    This file is part of the Cyclone Scheme WiringPi Bindings.
;;
;;    The Cyclone Scheme WiringPi Bindings are free software: you can 
;;    redistribute and/or modify them under the terms of the GNU General
;;    Public License as published by the Free Software Foundation, either
;;    version 3 of the License, or (at your option) any later version.
;;
;;    The Cyclone Scheme WiringPi Bindings are distributed in the hope 
;;    that they will be useful, but WITHOUT ANY WARRANTY; without even the
;;    implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;;    See the GNU General Public License for more details.
;;
;;   You should have received a copy of the GNU General Public License
;;   along with the Cyclone Scheme WiringPi Bindings.  
;;   If not, see <https://www.gnu.org/licenses/>.
    
(define-library (raspberry-pi gpio pins)
  (import (scheme base))
  (include-c-header "<wiringPi.h>")

  (export pin-mode! set-pin! read-pin set-pull-up-down! set-pins!
	  INPUT OUTPUT PWM_OUTPUT
	  HIGH LOW
	  PUD_OFF PUD_DOWN PUD_UP)

  (begin
    (define-c pin-mode!
      "(void *data, int argc, closure _, object k, object pin, object mode)"
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

    (define-c set-pin!
      "(void *data, int argc, closure _, object k, object pin, object val)"
      " digitalWrite((int) (unbox_number(pin)), (int) (unbox_number(val)));
        return_closcall1(data, k, boolean_t);
      ")

    (define-c read-pin
      "(void *data, int argc, closure _, object k, object pin)"
      " int reading = digitalRead((int) (unbox_number(pin)));
        return_closcall1(data, k, obj_obj2int(reading));
      ")

    (define-c set-pull-up-down!
      "(void *data, int argc, closure _, object k, object pin, object state)"
      " int int_pin = (int) (unbox_number(pin));
        int int_state = (int) (unbox_number(state));
        if (int_state == 0) {
          pullUpDnControl(int_pin, PUD_OFF);
        } else if (int_state == 1) {
          pullUpDnControl(int_pin, PUD_DOWN);
        } else if (int_state == 2) {
          pullUpDnControl(int_pin, PUD_UP);
        } else {
          return_closcall1(data, k, boolean_f);
        }
        return_closcall1(data, k, boolean_t);
      ")

    (define-c set-pins!
      "(void *data, int argc, closure _, object k, object val)"
      " digitalWriteByte((int) (unbox_number(val)));
        return_closcall1(data, k, boolean_t);
      ")

    ;; Pin mode aliases
    (define OUTPUT 0)
    (define INPUT 1)
    (define PWM_OUTPUT 2)

    ;; Pin on/off aliases
    (define HIGH 1)
    (define LOW 0)

    ;; Pin pull up/down aliases
    (define PUD_OFF 0)
    (define PUD_DOWN 1)
    (define PUD_UP 2)))
