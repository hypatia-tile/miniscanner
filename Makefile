target := miniscanner

.PHONY: all clean run
all:
	cabal build

run:
	cabal run $(target)

clean:
	cabal clean

