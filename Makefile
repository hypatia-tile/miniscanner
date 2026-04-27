target := miniscanner
inputfile := example/test.txt

.PHONY: all clean run repl
all:
	cabal build

repl:
	cabal run $(target)

run:
	cabal run $(target) -- $(inputfile)

clean:
	cabal clean

