all: pwm test
# Build test #
test: test.scm
	../cyclone_link.scm test.scm -l wiringPi
# Build pwm #
pwm: pwm.scm
	../cyclone_link.scm pwm.scm -l wiringPi
