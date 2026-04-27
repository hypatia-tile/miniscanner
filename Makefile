target := miniscanner
inputfile := example/test.txt

.PHONY: all clean run
all:
	cabal build

run:
	cabal run $(target) -- $(inputfile)

clean:
	cabal clean

