# pl16_1

## Programming Languages - First Assignment

A programmable calculator

## Usage

Show usage message:

    $ ./main.rb -h

Run:

    $ ./main.rb # will read from stdin

As there is very little output this way you might want to specify --verbose
or -v for short:

    $ ./main.rb -v

There are four levels of verbosity

    $ ./main.rb        # almost no output
    $ ./main.rb -v     # tell us when input is expected
    $ ./main.rb -v -v  # log what steps are taken
    $ ./main.rb -vv    # shorthand for -v -v
    $ ./main.rb -vvv   # even more output

~~Output is read as soon as possible in unbuffered mode, which is the default.
Currently input will not be echoed in unbuffered mode.~~

Buffered mode was replaced by echo mode.
(Some examples might need to be updated.)

    $ ./main.rb -e # input will be echoed
    3 7 +          # you see what you type in
    w10            # input and output on the same line

There is an additional command 'S' for printing the current stack,
but it is disabled by default:

    $ ./main.rb -e
    SIllegal character 'S (83)' # leads to an error
    
    $ ./main.rb -e -E           # enable extendend mode
    Sstack []                   # input & output, the stack is currently empty

You can add a string to the input stream before the Calculator starts:

    $ ./main.rb -v -e -p "17 3" # acts as if your first input was "17 3"
    +w20                        # calculate 17 + 3 and print result

this will come in handy when running a program stored in a text file

    $ ./main.rb -vep "$(cat program.txt)" # start calculator with contents
                                          # of program.txt already on the
                                          # stack or executed

To give more helpful messages during execution two messages can be specified.
The options are called `-m` or `--messageReadInteger` and  `-M` or  `--messageReadBlock`:

    $ ./main.rb -vem "please input an integer in base 10"
    iplease input an integer in base 10
    456
    w456

On the stack blocks are shown as strings:

    $ $ ./main.rb -Eve
    5                # input
    bread block
    4+               # input block [4+]
    Sstack ["4+", 5]
    a                # apply
    Sstack [9]
    x                # quit


Run the prime factor example like so:

    $ ./main.rb -ev
    [[i1c0= [2 [1c 3c % 0= [1+] [1cw 2c 3d / 2] 3c 4d 1+ d a  2c 1=] [[4c 5d 4c 5d 4ca [4c5d 4c5d 1ca] [1d1d1d1d] 3c4d1+da] 1ca] a 1] [] [3c4d1+da] a]  [[2ca [1d1d] [1ca] 3c4d1+da] 1ca] a x] aread integer
    1001                  # input
    7 11 13 read integer  # output, 7 * 11 * 13 = 1001
    0                     # input, exit program

the output isn't that pretty but it seems to work

Better yet, just call the supplied bash script:

    $ ./runPrimeFactorization.bash
