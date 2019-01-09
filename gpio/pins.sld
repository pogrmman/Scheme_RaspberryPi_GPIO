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
  (include "better-c.scm")
  (include "pin-mode.scm")
  
  (export pin-mode! set-pin! read-pin set-pull-up-down! set-pins!
	  INPUT OUTPUT PWM_OUTPUT
	  HIGH LOW
	  PUD_OFF PUD_DOWN PUD_UP)

  (begin
    (def-c (set-pin! "pin" "val")
      " digitalWrite((int) (unbox_number(pin)), (int) (unbox_number(val)));
        return_closcall1(data, k, boolean_t);
      ")

    (def-c (read-pin "pin")
      " int reading = digitalRead((int) (unbox_number(pin)));
        return_closcall1(data, k, obj_obj2int(reading));
      ")

    (def-c (set-pull-up-down! "pin" "state")
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

    (def-c (set-pins! "val")
      " digitalWriteByte((int) (unbox_number(val)));
        return_closcall1(data, k, boolean_t);
      ")

    ;; Pin on/off aliases
    (define HIGH 1)
    (define LOW 0)

    ;; Pin pull up/down aliases
    (define PUD_OFF 0)
    (define PUD_DOWN 1)
    (define PUD_UP 2)))
