#Example makefile for using the gpio library
#Right now, I'm just manually appending -lwiringPi to the output of cyclone -d, but it should be possible to make it dynamic		
all: test.c test.o
	cc test.o  /usr/local/share/cyclone/scheme/cyclone/common.o  /usr/local/share/cyclone/scheme/base.o  /usr/local/share/cyclone/scheme/process-context.o gpio/timing.o  gpio/pins.o  gpio/setup.o  -pthread -lcyclone -lck -lm -ltommath -ldl -lwiringPi -O2 -fPIC -Wall -march=armv6k -I/usr/local/include -L/usr/local/lib -Wl,--export-dynamic -o test
test.c: test.scm
	cyclone -d test.scm
test.o: test.c
	cc test.c -O2 -fPIC -Wall -march=armv6k -I/usr/local/include -L/usr/local/lib -Wl,--export-dynamic -c -o test.o
clean:
	rm test.c
	rm test.o
	rm test
