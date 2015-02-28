# Exploring Conway's Game of Life using Racket
(cf. http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life and 
http://racket-lang.org/)

Late February 2015: humble beginnings inspired by a code retreat.

Run all tests, e.g. with
  $ time for t in test*.rkt;  do echo "test $t"; racket $t; done
test testNeighbors.rkt
test testStateBounds.rkt
test testStringsToState.rkt
test testTimeLessState.rkt
