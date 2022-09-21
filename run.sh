#!/bin/sh

set -e

max=$1
for ((i=0; i < $max; i++)); do
	./zig-out/bin/zig-random
done
