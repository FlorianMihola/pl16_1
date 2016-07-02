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
    $ /main.rb -vvv   # even more output

Output is read as soon as possible in unbuffered mode, which is the default.
Currently input will not be echoed in unbuffered mode.

    $ ./main.rb  # not pictured: put in 4 5+w
    9
    
    $ ./main.rb -b  # enable buffered mode
    5 4+w           # input is shown, but not read yet..
    9               # output read in and processed after enter was pressed

There is an additional command 'S' for printing the current stack,
but it is disabled by default:

    $ ./main.rb -b
    S                           # input
    Illegal character 'S (83)'  # leads to an error
    
    $ ./main.rb -b -e           # enable extendend mode
    S                           # input
    stack []                    # output, the stack is currently empty

On the stack blocks are shown as strings:

    $ ./main.rb -evb
    5                 # input
    b4+               # input block [4+]
    read block        # output
    S                 # input
    stack ["4+", 5]   # output
    a                 # input
    S                 # input
    stack [9]         # output
    x                 # input
    $                 # quit

Note that if you do:

    $ ./main.rb -be
    b
    4 5*             # you think this would be the input
    S                # let's check
    stack [20, ""]   # the block was empty because 'b' was followed by a
                     # newline character, which terminates the line and
                     # thus closes the block

try this instead:

    $ ./main.rb -be
    b4 5*            # put it on one line, 'b' is only passed to the calculator
                     # once the whole line was put in
    S
    stack ["4 5*"]   # now it's on the stack
    aS               # execute it and print stack
    stack [20]
