EMACS ?= emacs

INIT_PACKAGES="(progn \
  (package-initialize) \
  (unless (package-installed-p 'undercover) \
    (package-install 'undercover)))"

all: test

test: clean-elc
	${MAKE} unit
	${MAKE} compile
	${MAKE} unit
	${MAKE} clean-elc

unit:
	${EMACS} -Q --eval ${INIT_PACKAGES} -batch -l test.el --eval "(ert t)"

compile:
	${EMACS} -Q -batch -f batch-byte-compile unfill.el

clean-elc:
	rm -f f.elc

.PHONY:	all test
