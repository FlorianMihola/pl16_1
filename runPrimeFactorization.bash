#!/bin/bash

cd src &&
./main.rb -evp "$(cat ../primeFactorization.txt)" -m $'\ninput integer, 0 to quit'

exit 0
