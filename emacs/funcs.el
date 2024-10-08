;;; funcs.el --- my personal functions
;;; Commentary:
;;; Code:

(defun open-line-inplace ()
  "Insert empty line in place, where cursor is, moving the
content of the line below."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent))

(defun open-line-below ()
  "Insert empty line after the current one and move the cursor
to its beginning following the mode's indentantion rules."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(defun open-line-above ()
  "Insert an empty line above the current line and move cursor
to its beginning following the mode's indentation rules."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun sign-patch-off-by ()
  (interactive)
  (with-eval-after-load 'magit
	(let ((name (magit-git-string "config" "user.name"))
		   (email (magit-git-string "config" "user.email")))
      (insert (format "Signed-off-by: %s <%s>" name email)))))

;;; funcs.el ends here
