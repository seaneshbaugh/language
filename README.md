# Language

This is a toy Lisp-like* language that for now is just called "Language" (naming things is hard). It doesn't really do anything interesing yet. If this goes anywhere it'll probably end up as sort of a weird mix between Common Lisp, Scheme, and Ruby.

The language itself is implemented in Ruby. Hopefully that will change in the future. For now I'm leveraging the fact that Ruby handles all of the hard stuff (memory management especially) for me to keep my own code naive and hopefully simple. In the future I might re-write this in Haskell or Elixir. The current code is very inelegant and I suspect the fact that the AST is a weird mix of tokens and expressions is going to make it hard to implement some stuff in the future.

*"Lisp-like" because I don't think this will ever meet all the criteria (as far as they've been codified) of a full-fledged lisp. Also, I have no idea what I'm doing.

## Running a Program

To run a program run `bin/language` and pass it the path to a file.

## Implemented

* Lexer

* Simple printing of values

## Partially Implemented

* Command-line script
* Parser
* Interpreter

* Numbers
* Strings
* Booleans

* Simple testing for equality
* Adding numbers
* Adding strings
* Numerical product
* String length

## Not Implemented

* Tests
* Useful error messages
* REPL

* Lists (I know, right?)
* nil (or empty list)
* Functions
* Lambdas
* Hash Tables/Dictionaries
* Atoms

* Cons, car, cdr
* Conditional branching
* All other arithmetic
* The usual list functions like map and fold
* Local variables
* Any kind of scoping/closure
* quote/unquote
* Macros
