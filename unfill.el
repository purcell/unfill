;;; unfill.el --- Do the opposite of fill-paragraph or fill-region  -*- lexical-binding: t -*-

;; Copyright (C) 2012-2020 Steve Purcell.

;; Author: Steve Purcell <steve@sanityinc.com>
;; Homepage: https://github.com/purcell/unfill
;; Package-Version: 0
;; Package-Requires: ((emacs "24.1"))
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; Provides commands for explicitly unfilling (ie. unwrapping)
;; paragraphs and regions, and also a command that will toggle between
;; filling and unfilling the current paragraph or region.

;; Based initially on Xah Lee's examples, and later rewritten based on an article by Artur Malabarba.
;;   http://endlessparentheses.com/fill-and-unfill-paragraphs-with-a-single-key.html
;;   http://xahlee.org/emacs/emacs_unfill-paragraph.html
;;   http://xahlee.org/emacs/modernization_fill-paragraph.html

;;; Code:

;;;###autoload
(defun unfill-paragraph ()
  "Replace newline chars in current paragraph by single spaces.
This command does the inverse of `fill-paragraph'."
  (interactive)
  (let ((fill-column most-positive-fixnum))
    (call-interactively 'fill-paragraph)))

;;;###autoload
(defun unfill-region (start end)
  "Replace newline chars in region from START to END by single spaces.
This command does the inverse of `fill-region'."
  (interactive "r")
  (let ((fill-column most-positive-fixnum))
    (fill-region start end)))

(defvar unfill-functions (list 'fill-paragraph 'unfill-paragraph)
  "Functions for unfill-cycle to format the paragraph at point.
This variable should be a list of functions that don't take arguments.")

;;;###autoload
(defun unfill-cycle ()
  "Cycle formating of the current region, or current paragraph if no region active."
  (interactive)
  (funcall (cycle-on-repetition unfill-functions))
  )

(defvar repetition-counter 0
  "How often cycle-on-repetition has been called in a row using the same command.")

;;;###autoload
(defun cycle-on-repetition (list-of-expressions)
  "Return the first element from the list on the first call,
   the second expression on the second consecutive call etc"
  (interactive)
  (if (equal this-command last-command)
      (setq repetition-counter (+ repetition-counter 1))
    (setq repetition-counter 0)
    )
  (nth
   (mod repetition-counter (length list-of-expressions))
   list-of-expressions))


;;;###autoload
(define-obsolete-function-alias 'toggle-fill-unfill 'unfill-cycle "0.2")

;;;###autoload
(define-obsolete-function-alias 'toggle-toggle 'unfill-cycle "0.4")

(provide 'unfill)
;;; unfill.el ends here
