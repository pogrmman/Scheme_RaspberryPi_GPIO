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

(define-library (raspberry-pi gpio setup)
  (import (scheme base))
  (include-c-header "<wiringPi.h>")

  (export gpio-setup! gpio-setup-BCM! gpio-setup-SYS!)

  (begin
    (define-c gpio-setup!
      "(void *data, int argc, closure _, object k)"
      "int succ = wiringPiSetup();
       if (succ == -1) {
         return_closcall1(data, k, boolean_f);
       }
       return_closcall1(data, k, boolean_t);
      ")

    (define-c gpio-setup-BCM!
      "(void *data, int argc, closure _, object k)"
      "int succ = wiringPiSetupGpio();
       if (succ == -1) {
         return_closcall1(data, k, boolean_f);
       }
       return_closcall1(data, k, boolean_t);
      ")

    (define-c gpio-setup-SYS!
      "(void *data, int argc, closure _, object k)"
      "int succ = wiringPiSetupSys();
       if (succ == -1) {
         return_closcall1(data, k, boolean_f);
       }
       return_closcall1(data, k, boolean_t);
      ")))
