# Cyclone Scheme bindings for wiringPi
These libraries provide [Cyclone Scheme](https://justinethier.github.io/cyclone/index)
bindings for the [wiringPi Library](https://wiringpi.com).

This lets you use the Raspberry Pi's GPIO pins from scheme code.

## Dependencies
You need to have installed WiringPi and Cyclone Scheme to use this library.

## Usage
Place the `gpio` folder within a folder called `raspberry-pi` that is on the path searched by Cyclone for Scheme libs 
(this path can be set with the `CYCLONE_LIBRARY_PATH` environment variable). Because of the way Cycone works, you'll need to compile each of the modules in the library by using `cyclone $MODULE_NAME$.sld`.

You can then make the library available in your R7RS code by placing `(raspberry-pi gpio $MODULE$)` inside of the `(import)` statement at the start of your code. You need to run one of the setup commands from `(raspberry-pi gpio setup)` module before using any of the other features, just like how you need to run one of the setup commands in WiringPi.

When compiling your code, you'll need to use `cyclone -d $PROGRAM$`, then run the two commands cyclone suggests, adding a `-lwiringPi` flag to the second one. This should be improved in the future, but it does produce a functional executable. See the example Makefile for suggestions. 

## Unsupported features
I currently haven't written bindings for the threading and interrupt functionality provided by WiringPi.
They shouldn't be that hard to write, however.
