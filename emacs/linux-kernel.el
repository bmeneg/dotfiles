(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(dir-locals-set-class-variables
 'linux-kernel
 '((c-ts-mode . (
              (c-basic-offset . 8)
              (c-label-minimum-indentation . 0)
              (c-offsets-alist . (
				  (arglist-close         . c-lineup-arglist-tabs-only)
				  (arglist-cont-nonempty .
							 (c-lineup-gcc-asm-reg c-lineup-arglist-tabs-only))
				  (arglist-intro         . +)
				  (brace-list-intro      . +)
				  (c                     . c-lineup-C-comments)
				  (case-label            . 0)
				  (comment-intro         . c-lineup-comment)
				  (cpp-define-intro      . +)
				  (cpp-macro             . -1000)
				  (cpp-macro-cont        . +)
				  (defun-block-intro     . +)
				  (else-clause           . 0)
				  (func-decl-cont        . +)
				  (inclass               . +)
				  (inher-cont            . c-lineup-multi-inher)
				  (knr-argdecl-intro     . 0)
				  (label                 . -1000)
				  (statement             . 0)
				  (statement-block-intro . +)
				  (statement-case-intro  . +)
				  (statement-cont        . +)
				  (substatement          . +)
				  ))
              (indent-tabs-mode . t)
              (show-trailing-whitespace . t)
	      ;; some weird stuff happens here, but the 'let' and 'when' body
	      ;; changes the evaluation context, allowing the code to work.
	      ;; If we directly try to (setq tags-filename (...)) it doesn't work!!
	      ;; (eval .
	      ;; 	    (let ((proj (project-current t)))
	      ;; 	      (when proj
	      ;; 		(let ((filename (expand-file-name "TAGS" (project-root proj))))
	      ;; 		  (progn
	      ;; 		    (setq large-file-warning-threshold nil)
	      ;; 		    (setq tags-file-name filename))))))
	      (eval . (setq company-clang-arguments
			    (concat "-I" (expand-file-name "~/git/linux/include/"))))
	      (eval . (add-to-list 'company-c-headers-path-user
				   (expand-file-name "~/git/linux/include/")))))))

(dir-locals-set-directory-class
 (expand-file-name "~/git/linux")
 'linux-kernel)
(dir-locals-set-directory-class
 (expand-file-name "~/git/redhat/linux/rhel6")
 'linux-kernel)
(dir-locals-set-directory-class
 (expand-file-name "~/git/redhat/linux/rhel7")
 'linux-kernel)
(dir-locals-set-directory-class
 (expand-file-name "~/git/redhat/linux/rhel8")
 'linux-kernel)
(dir-locals-set-directory-class
 (expand-file-name "~/git/redhat/linux/rhel9")
 'linux-kernel)
(dir-locals-set-directory-class
 (expand-file-name "~/git/redhat/linux/cs9")
 'linux-kernel)
