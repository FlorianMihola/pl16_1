#!/bin/bash

cd src &&
./main.rb -bvp "$(cat ../primeFactorization.txt)" -m $'\ninput integer, 0 to quit'

exit 0
