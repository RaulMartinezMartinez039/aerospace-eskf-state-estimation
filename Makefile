CC = gcc
CFLAGS = -std=c11 -O2 -Wall -Wextra -Wpedantic
CPPFLAGS = -Isrc
LDLIBS = -lm

.PHONY: all test simulations clean
all: build/prueba_fusion build/simulacion build/simulacion_3d

build:
	mkdir -p build

build/prueba_fusion: tests/prueba_fusion.c src/fusion.c src/fusion.h | build
	$(CC) $(CPPFLAGS) $(CFLAGS) tests/prueba_fusion.c src/fusion.c -o $@ $(LDLIBS)

build/simulacion: simulations/simulacion.c src/fusion.c src/fusion.h | build
	$(CC) $(CPPFLAGS) $(CFLAGS) simulations/simulacion.c src/fusion.c -o $@ $(LDLIBS)

build/simulacion_3d: simulations/simulacion_3d.c src/fusion.c src/fusion.h | build
	$(CC) $(CPPFLAGS) $(CFLAGS) simulations/simulacion_3d.c src/fusion.c -o $@ $(LDLIBS)

test: build/prueba_fusion
	cd build && ./prueba_fusion

simulations: build/simulacion build/simulacion_3d
	cd build && ./simulacion
	cd build && ./simulacion_3d

clean:
	rm -rf build
