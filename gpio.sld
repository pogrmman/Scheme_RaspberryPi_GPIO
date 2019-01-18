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

;; This library imports all of the wiringPi wrapper modules and exports the same
;; api that they do.
(define-library (raspberry-pi gpio)
  (import (scheme base)
	  (raspberry-pi gpio pins)
	  (raspberry-pi gpio pwm)
	  (raspberry-pi gpio setup)
	  (raspberry-pi gpio timing)
	  (raspberry-pi gpio threading)
	  (raspberry-pi gpio misc))

  (export pin-mode! set-pin! read-pin set-pull-up-down! set-pins!
	  pwm-set-pin! pwm-set-mode! pwm-set-range! pwm-set-clock!
	  gpio-setup! gpio-setup-BCM! gpio-setup-SYS!
	  wait! us-wait! millis
	  def-thread start-thread! mutex-lock! mutex-unlock!
	  pi-board-rev wiringPi->BCM set-pad-drive!
	  INPUT OUTPUT PWM_OUTPUT
	  HIGH LOW
	  PUD_OFF PUD_DOWN PUD_UP
	  PWM_BALANCED PWM_MS))
