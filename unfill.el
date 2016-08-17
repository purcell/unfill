;;; unfill.el --- Unfill paragraphs or regions, and toggle between filled & unfilled

;; Copyright (C) 2012-2016 Steve Purcell.

;; Author: Steve Purcell <steve@sanityinc.com>
;; X-URL: https://github.com/purcell/unfill
;; Version: DEV
;; Keywords: utilities

;;; Commentary:

;; Provides commands for explicitly unfilling (ie. unwrapping)
;; paragraphs and regions, and also a command that will toggle between
;; filling and unfilling the current paragraph or region.

;; Based initially on Xah Lee's examples, and later rewritten based on an article by Artur Malabarba.
;;   http://endlessparentheses.com/fill-and-unfill-paragraphs-with-a-single-key.html
;;   http://xahlee.org/emacs/emacs_unfill-paragraph.html
;;   http://xahlee.org/emacs/modernization_fill-paragraph.html

;; This file is NOT part of GNU Emacs.

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

;;;###autoload
(defun unfill-toggle ()
  "Toggle filling/unfilling of the current region, or current paragraph if no region active."
  (interactive)
  (let (deactivate-mark
        (fill-column
         (if (eq last-command this-command)
             (progn (setq this-command nil)
                    most-positive-fixnum)
           fill-column)))
    (call-interactively 'fill-paragraph)))

;;;###autoload
(define-obsolete-function-alias 'toggle-fill-unfill 'unfill-toggle)

(provide 'unfill)
;;; unfill.el ends here
