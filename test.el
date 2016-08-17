(when (require 'undercover nil t)
  (undercover "unfill.el"))
(load-file "unfill.el")

(defvar unfill-test-example "This
is the
first paragraph.

This is the
second paragraph.
")
(ert-deftest unfill-paragraph-should-work-on-the-current-paragraph-only ()
  (with-temp-buffer
    (insert unfill-test-example)
    (goto-char (point-min))
    (unfill-paragraph)
    (should (string= (buffer-string)
                     "This is the first paragraph.

This is the
second paragraph.
"))))

(ert-deftest unfill-region-should-work-on-the-defined-region ()
  (with-temp-buffer
    (insert unfill-test-example)
    (unfill-region 0 28)
    (should (string= (buffer-string)
                     "This is the first paragraph.

This is the
second paragraph.
"))))

(ert-deftest unfill-region-preserves-paragraphs ()
  (with-temp-buffer
    (insert unfill-test-example)
    (unfill-region (point-min) (point-max))
    (should (string= (buffer-string)
                     "This is the first paragraph.

This is the second paragraph.
"))))

(ert-deftest unfill-toggle-on-paragraph ()
  (with-temp-buffer
    (let ((initial (apply 'concat "blah" (make-list 70 " blah"))) wrapped)
      (insert initial)
      (fill-paragraph)
      (setq wrapped (buffer-string))
      (should-not (string= wrapped initial))
      ;; Toggling once: unfill
      (setq last-command 'self-insert-command)
      (setq this-command 'unfill-toggle)
      (unfill-toggle)
      (should (string= (buffer-string) initial))
      ;; Toggling twice: fill
      (setq last-command this-command)
      (setq this-command 'unfill-toggle)
      (unfill-toggle)
      (should (string= (buffer-string) wrapped))
      ;; Toggling three times: unfill
      (setq last-command this-command)
      (setq this-command 'unfill-toggle)
      (unfill-toggle)
      (should (string= (buffer-string) initial)))))

(ert-deftest unfill-toggle-on-region ()
  (with-temp-buffer
    (let ((initial (concat (apply 'concat "blah" (make-list 70 " blah")) "\n\nSecond paragraph goes here")) wrapped)
      (insert initial)
      (goto-char (point-min))
      (fill-paragraph)
      (setq wrapped (buffer-string))
      (should-not (string= wrapped initial))
      (goto-char (point-min))
      (set-mark-command nil)
      (goto-char (point-max))
      (transient-mark-mode 1)
      ;; Toggling once: unfill
      (setq last-command 'self-insert-command)
      (setq this-command 'unfill-toggle)
      (unfill-toggle)
      (should (string= (buffer-string) initial))
      ;; Toggling twice: fill
      (setq last-command this-command)
      (setq this-command 'unfill-toggle)
      (unfill-toggle)
      (should (string= (buffer-string) wrapped))
      ;; Toggling three times: unfill
      (setq last-command this-command)
      (setq this-command 'unfill-toggle)
      (unfill-toggle)
      (should (string= (buffer-string) initial)))))
