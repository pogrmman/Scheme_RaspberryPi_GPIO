;; Example usage of wiringPi bindings
;; This program blinks an LED connected to a GPIO pin
;; To use it, compile with make test, then run ./test
;; $PIN_NUMBER$
(import (scheme base)
        (scheme process-context)
        (raspberry-pi gpio setup)
        (raspberry-pi gpio pins)
        (raspberry-pi gpio timing))

(begin
 (gpio-setup!)
 (let* ((args (command-line-arguments))
        (pin (pin-mode! (string->number (car args)) OUTPUT)))
   (let kernel ((counter 10))
    (if (not (zero? counter))
        (begin
         (set-pin! pin HIGH)
         (wait! 100)
         (set-pin! pin LOW)
         (wait! 100)
         (kernel (- counter 1)))))))
