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

(define-library (raspberry-pi gpio pwm)
  (import (scheme base))
  (include-c-header "<wiringPi.h>")
  (include "better-c.scm")
  (include "pin-mode.scm")
  
  (export pin-mode! pwm-set-pin! pwm-set-mode! pwm-set-range! pwm-set-clock!
	  PWM_BALANCED PWM_MS
	  INPUT OUTPUT PWM_OUTPUT)

  (begin
    ;; C Wrappers
    (def-c (pwm-set-pin! "pin" "val")
      " pwmWrite((int) (unbox_number(pin)), (int) (unbox_number(val)));
        return_closcall1(data, k, boolean_t);
      ")

    (def-c (pwm-set-mode! "mode")
      " int int_mode = (int) (unbox_number(mode));
        if (int_mode == 0) {
          pwmSetMode(PWM_MODE_BAL);
        } else if (int_mode == 1) {
          pwmSetMode(PWM_MODE_MS);
        } else {
          return_closcall1(data, k, boolean_f);
        }
        return_closcall1(data, k, boolean_t);
      ")
 
    (def-c (pwm-set-range! "val")
      " pwmSetRange((unsigned int) (unbox_number(val)));
        return_closcall1(data, k, boolean_t);
      ")

    (def-c (pwm-set-clock! "val")
      " pwmSetClock((int) (unbox_number(val)));
        return_closcall1(data, k, boolean_t);
      ")

    ;; Mode Aliases
    (define PWM_BALANCED 0)
    (define PWM_MS 1)))
