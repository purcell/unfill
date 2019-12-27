EMACS ?= emacs

INIT_PACKAGES="(progn \
  (require 'package) \
  (push '(\"melpa\" . \"https://melpa.org/packages/\") package-archives) \
  (package-initialize) \
  (package-refresh-contents) \
    (unless (package-installed-p 'package-lint) \
    (package-install 'package-lint)) \
  (unless (package-installed-p 'undercover) \
    (package-install 'undercover)))"

all: compile package-lint unit clean-elc

unit:
	${EMACS} -Q --eval ${INIT_PACKAGES} -batch -l test.el --eval "(ert t)"

package-lint:
	${EMACS} -Q --eval ${INIT_PACKAGES} -batch -f package-lint-batch-and-exit unfill.el

compile: clean-elc
	${EMACS} -Q -batch -f batch-byte-compile unfill.el

clean-elc:
	rm -f f.elc

.PHONY:	all compile unit clean-elc package-lint
