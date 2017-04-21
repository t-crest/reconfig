# The makefile of the reconfig repository.
# Luca Pezzarossa (lpez@dtu.dk)

all: tools

tools: convbitstream

convbitstream: ./tools/convbitstream/convbitstream.c
	gcc -std=c99 -o ./tools/bin/convbitstream `xml2-config --cflags` ./tools/convbitstream/convbitstream.c `xml2-config --libs` -lm

