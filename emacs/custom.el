(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(duplicate-line-final-position 1)
 '(inhibit-startup-screen t)
 '(package-selected-packages
	  '(rtags perlbrew rainbow-delimiters paredit cider clojure-ts-mode clojure-mode eglot company-c-headers ggtag ggtags clang-format smex dired-icon markdown-mode powerline use-package python-mode projectile magit helm flycheck evil-visual-mark-mode editorconfig))
 '(safe-local-variable-values
	  '((eval eglot-ensure)
		   (eglot-server-programs
			   (c-ts-mode "clangd-19" "--compile-commands-dir=build"))
		   (eval when
			   (eglot-managed-p)
			   (eglot-shutdown
				   (eglot-current-server)))
		   (eval add-to-list 'company-c-headers-path-user
			   (expand-file-name "~/git/linux/include/"))
		   (eval setq company-clang-arguments
			   (concat "-I"
				   (expand-file-name "~/git/linux/include/")))
		   (eval add-to-list 'company-c-headers-path-user
			   (expand-file-name "~/git/linux/"))
		   (eval setq company-clang-arguments
			   (concat "-I"
				   (expand-file-name "~/git/linux/")))
		   (eval add-to-list 'company-c-headers-path-user
			   (expand-file-name "./include/"))
		   (eval setq company-clang-arguments
			   (concat "-I"
				   (expand-file-name "./include/")))
		   (add-to-list 'company-c-headers-path-user . "./include/")
		   (company-clang-arguments . "-I./include")
		   (add-to-list 'company-c-headers-path-user "./include/")
		   (company-clang-arguments "-I./include")
		   (eval let
			   ((proj
					(project-current t)))
			   (when proj
				   (let
					   ((filename
							(expand-file-name "TAGS"
								(project-root proj))))
					   (progn
						   (setq large-file-warning-threshold nil)
						   (setq tags-file-name filename)))))
		   (c-offsets-alist
			   (arglist-close . c-lineup-arglist-tabs-only)
			   (arglist-cont-nonempty c-lineup-gcc-asm-reg c-lineup-arglist-tabs-only)
			   (arglist-intro . +)
			   (brace-list-intro . +)
			   (c . c-lineup-C-comments)
			   (case-label . 0)
			   (comment-intro . c-lineup-comment)
			   (cpp-define-intro . +)
			   (cpp-macro . -1000)
			   (cpp-macro-cont . +)
			   (defun-block-intro . +)
			   (else-clause . 0)
			   (func-decl-cont . +)
			   (inclass . +)
			   (inher-cont . c-lineup-multi-inher)
			   (knr-argdecl-intro . 0)
			   (label . -1000)
			   (statement . 0)
			   (statement-block-intro . +)
			   (statement-case-intro . +)
			   (statement-cont . +)
			   (substatement . +))
		   (c-label-minimum-indentation . 0)))
 '(warning-minimum-level :error))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
