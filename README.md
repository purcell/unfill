[![Melpa Status](http://melpa.org/packages/unfill-badge.svg)](http://melpa.org/#/unfill)
[![Melpa Stable Status](http://stable.melpa.org/packages/unfill-badge.svg)](http://stable.melpa.org/#/unfill)
[![Build Status](https://github.com/purcell/unfill/workflows/CI/badge.svg)](https://github.com/purcell/unfill/actions)
<a href="https://www.patreon.com/sanityinc"><img alt="Support me" src="https://img.shields.io/badge/Support%20Me-%F0%9F%92%97-ff69b4.svg"></a>

unfill
======

Functions providing the inverse of Emacs' fill-paragraph and fill-region

### Installation

Preferred method: install from [MELPA](http://melpa.org/).

Otherwise:

    (add-to-list 'load-path "/dir/containing/unfill")
    (require 'unfill)

### Usage

    M-x unfill-region
    M-x unfill-paragraph
    M-x unfill-cycle

### unfill-cycle

By default ~unfill-cycle~ toggles the paragraph at point between filled and unfilled.

You can customize this behavior by setting the list-variable ~unfill-functions~ in your emacs-config.
~unfill-cycle~ will then format the paragraph according to the first function on it's first call, to the second function on it's second consecutive call, etc.

    (setq unfill-functions (list 'fill-paragraph 'unfill-paragraph 'my-own-function-for-formating-paragraphs))

<hr>

Author links:

[💝 Support this project and my other Open Source work](https://www.patreon.com/sanityinc)

[💼 LinkedIn profile](https://uk.linkedin.com/in/stevepurcell)

[✍ sanityinc.com](http://www.sanityinc.com/)

[🐦 @sanityinc](https://twitter.com/sanityinc)
