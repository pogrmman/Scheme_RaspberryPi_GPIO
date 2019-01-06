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

(define-library (raspberry-pi gpio timing)
  (import (scheme base))
  (include-c-header "<wiringPi.h>")

  (export wait! us-wait! millis)

  (begin
    (define-c wait!
      "(void *data, int argc, closure _, object k, object time)"
      " delay((unsigned int) (unbox_number(time)));
        return_closcall1(data, k, boolean_t);
      ")

    (define-c us-wait!
      "(void *data, int argc, closure _, object k, object time)"
      " delayMicroseconds((unsigned int) (unbox_number(time)));
        return_closcall1(data, k, boolean_t);
      ")

    (define-c millis
      "(void *data, int argc, closure _, object k)"
      " unsigned int result = millis();
        return_closcall1(data, k, obj_obj2int(result));
      ")))
