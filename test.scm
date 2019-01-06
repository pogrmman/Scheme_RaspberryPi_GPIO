;; Example usage of wiringPi bindings
;; This program blinks an LED connected to wiringPi GPIO pin 6 (Broadcom GPIO pin 25) 
(import (scheme base)
	(raspberry-pi gpio setup)
	(raspberry-pi gpio pins)
	(raspberry-pi gpio timing))

(begin
  (gpio-setup!)
  (pin-mode! 6 OUTPUT)
  (let kernel ((counter 10))
    (if (not (zero? counter))
	(begin
	  (set-pin! 6 HIGH)
	  (wait 100)
	  (set-pin! 6 LOW)
	  (wait 100)
	  (kernel (- counter 1))))))
