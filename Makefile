EMACS ?= emacs
CASK_EXEC ?= cask exec

all: test

test: clean-elc
	${MAKE} unit
	${MAKE} compile
	${MAKE} unit
	${MAKE} clean-elc

unit:
	${CASK_EXEC} ${EMACS} -Q -batch -l test.el --eval "(ert t)"

compile:
	${CASK_EXEC} ${EMACS} -Q -batch -f batch-byte-compile unfill.el

clean-elc:
	rm -f f.elc

.PHONY:	all test
