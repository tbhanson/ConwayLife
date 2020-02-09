# Exploring Conway's Game of Life using Racket
(cf. http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life and 
http://racket-lang.org/)

Late February 2015: humble beginnings inspired by a code retreat.

Run all tests, e.g. in a bash shell (with racket installed and in the path) with 

    for t in test/*.rkt;  do echo "test $t"; racket $t; done

(At the moment the animation tests run about a minute and require you to click their windows closed when they finish.)
