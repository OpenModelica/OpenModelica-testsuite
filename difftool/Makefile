ifdef OMDEV
CC = gcc
EXT=".exe"
endif

../$(OMBUILDDIR)/bin/omc-diff$(EXT): lex.yy.o ../$(OMBUILDDIR)/bin
	@test -s ../$(OMBUILDDIR)/bin/omc$(EXT) || { echo "Warning: OMC not found in ../$(OMBUILDDIR)/bin. Invoke make with OMBUILDDIR=.. to specify the build directory of OMCompiler."; }
	$(CC) -o $@ lex.yy.o

lex.yy.c: omc-diff.l
	flex omc-diff.l

../$(OMBUILDDIR)/bin:
	mkdir -p "$@"

clean:
	rm *.o
