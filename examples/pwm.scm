;; Example usage of wiringPi bindings
;; This program ramps up and down the brightness of an LED
;; hooked up to BCM pin 18 (wiringPi pin 1) using PWM
;; To use it, compile with make pwm, then run the pwm
;; executable as root (pwm requires root for reasons that
;; are unclear to me)
(import (scheme base)
	(raspberry-pi gpio setup)
	(raspberry-pi gpio timing)
	(raspberry-pi gpio pwm))

(define (ramp-up! pin)
  (let ((pred (lambda (n) (< n 1024)))
	(op (lambda (n) (+ n 1))))
    ((ramper! 0 pred op) pin)))

(define (ramp-down! pin)
  (let ((pred (lambda (n) (> n 0)))
	(op (lambda (n) (- n 1))))
    ((ramper! 1024 pred op) pin)))

(define (ramper! start pred op)
  (lambda (pin)
    (let kernel ((counter start))
      (if (pred counter)
	  (begin
	    (pwm-set-pin! pin counter)
	    (wait! 5)
	    (kernel (op counter)))))))
(begin
  (gpio-setup!)
  (let ((pin (pin-mode! 1 PWM_OUTPUT)))
    (let kernel ((counter 10))
      (if (> counter 0)
	  (begin
	    (ramp-up! pin)
	    (ramp-down! pin)
	    (kernel (- counter 1)))))))
