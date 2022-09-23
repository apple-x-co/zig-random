#!/bin/sh

set -e

format=$1
max=$2
for ((i=0; i < ${max}; i++)); do
	./zig-out/bin/zig-random ${format}
done
