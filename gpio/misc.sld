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

(define-library (raspberry-pi gpio misc)
  (import (scheme base))
  (include-c-header "<wiringPi.h>")
  (include "better-c.scm")

  (export pi-board-rev wiringPi->BCM set-pad-drive!)

  (begin
    (def-c pi-board-rev
      "int board_rev = piBoardRev();
       return_closcall1(data, k, obj_obj2int(board_rev);
      ")

    (def-c (wiringPi->BCM "pin")
      "int BCM_pin = wpiPinToGpio((int) (unbox_number(pin)));
       return_closcall1(data, k, obj_obj2int(BCM_pin);
      ")

    (def-c (set-pad-drive! "group" "value")
      "setPadDrive((int) (unbox_number(group)), (int) (unbox_number(value)));
       return_closcall1(data, k, boolean_t);
      ")))
