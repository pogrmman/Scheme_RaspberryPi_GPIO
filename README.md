# Cyclone Scheme bindings for wiringPi
These libraries provide [Cyclone Scheme](https://justinethier.github.io/cyclone/index)
bindings for the [wiringPi Library](https://wiringpi.com).

This lets you use the Raspberry Pi's GPIO pins from scheme code.

## Dependencies
You need to have installed WiringPi and Cyclone Scheme to use this library.

## Usage
Place the `gpio` folder within a folder called `raspberry-pi` that is on the path searched by Cyclone for Scheme libs 
(this path can be set with the `CYCLONE_LIBRARY_PATH` environment variable). Because of the way Cycone works, you'll need to compile each of the modules in the library first. You can do this by running `make` to compile all modules, or `make $MODULE$` to compile a specific module.

You can then make the library available in your R7RS code by placing `(raspberry-pi gpio $MODULE$)` inside of the `(import)` statement at the start of your code. You need to run one of the setup commands from `(raspberry-pi gpio setup)` module before using any of the other features, just like how you need to run one of the setup commands in WiringPi.

To compile your code, please use the provided `cyclone_link.scm` script with `-l wiringPi`. Cyclone does not currently have a way to specify additional libraries to link in, so this script runs the commands cyclone would with the addition of any libraries provided to the script. This script requires you have a file called `scheme-r7rs` in `/usr/bin/env/` that runs a scheme interpreter (like `icyc -s`).

## Unsupported features
I currently haven't written bindings for the threading and interrupt functionality provided by WiringPi.
They shouldn't be that hard to write, however.
