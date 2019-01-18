(import (scheme base)
	(scheme write)
	(raspberry-pi gpio misc)
	(raspberry-pi gpio setup))
(begin
  (gpio-setup!)
  (display "Pi Board Revision is: ")
  (display (pi-board-rev))
  (newline)
  (display "WiringPi pin 4 is BCM pin: ")
  (display (wiringPi->BCM 4))
  (newline)
  (display "Physical pin 4 is BCM pin: ")
  (display (phys->BCM 4))
  (newline))
