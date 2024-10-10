;; Reduce emacs startup time by decreasing the about of gc done
(setq gc-cons-threshold (* 10 1000 1000))
(add-hook 'emacs-start-hook
	  #'(lambda ()
	      (message "Startup in %s sec with %d garbage collections"
		       (emacs-init-time "%.2f")
		       gcs-done)))

;; Set lisp compiler to run underneath for SLIME
(setq-default inferior-lisp-program "sbcl")

;;; Package/plugin management
(require 'package)

;; package manager custom repos
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("elpa" . "http://orgmode.org/elpa"))
;;(setq package-enable-at-startup nil)
(package-initialize)

;; Certify to install 'use-package' package to manage default packages
;; that should be installed in the startup
(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))
(eval-when-compile
  (require 'use-package))

;;; Install minimum set of generic plugins
;; Tmux powerline
(use-package powerline
  :ensure t
  :init (powerline-default-theme))

;; Git commands from emacs
(use-package magit
  :ensure t)

;; Syntax checker to replace flymake, which is bundled with emacs
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; Autocomplete with LSP support
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1))

;; Ability to see the undo tree
;; NOTE: manually patched, check .emacs.d/elpa/queue/*.patch
(use-package undo-tree
  :ensure t
  :config
  (progn
    (global-undo-tree-mode 1)
    (setq undo-tree-auto-save-history nil)))

;; File manager
(use-package posframe
  :ensure t)

;; M-x with IDO support
(use-package smex
  :ensure t)

;; Allow multiple cursor editting and other things
(use-package multiple-cursors
  :ensure t)

;; C code formatting
(use-package clang-format
  :ensure t
  :config
  (setq clang-format-executable "clang-format-17"))

(use-package ggtags
  :ensure t)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; Language specific package
(use-package python
  :mode (("\\.py\\'" . python-ts-mode))
  :hook ((python-ts-mode . company-mode)
	 (python-ts-mode . eglot-ensure)))

(use-package go-mode
  :mode (("\\.go\\'" . go-ts-mode))
  :hook ((go-ts-mode . company-mode)
	 (go-ts-mode . eglot-ensure)))

(use-package rust-mode
  :mode (("\\.rs\\'" . rust-ts-mode))
  :hook ((rust-ts-mode . company-mode)
	 (rust-ts-mode . eglot-ensure)))

(use-package sh-mode
  :mode (("\\.sh\\'" . bash-ts-mode))
  :hook ((bash-ts-mode . company-mode)
	 (bash-ts-mode . eglot-ensure)))

(use-package c-mode
  :mode (("\\.c\\'" . c-ts-mode))
  :hook ((c-ts-mode . company-mode)))


;;;; Plugins specific defaults
;; Tree-sitter (emacs builtin) language grammar alist
(setq treesit-language-source-alist
  '((bash "https://github.com/tree-sitter/tree-sitter-bash")
    (c "https://github.com/tree-sitter/tree-sitter-c")
    (cmake "https://github.com/uyha/tree-sitter-cmake")
    (common-lisp "https://github.com/theHamsta/tree-sitter-commonlisp")
    (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
    (css "https://github.com/tree-sitter/tree-sitter-css")
    (csharp "https://github.com/tree-sitter/tree-sitter-c-sharp")
    (elisp "https://github.com/Wilfred/tree-sitter-elisp")
    (go "https://github.com/tree-sitter/tree-sitter-go" "v0.20.0")
    (gomod "https://github.com/camdencheek/tree-sitter-go-mod")
    (html "https://github.com/tree-sitter/tree-sitter-html")
    (js . ("https://github.com/tree-sitter/tree-sitter-javascript" "master" "src"))
    (json "https://github.com/tree-sitter/tree-sitter-json")
    (lua "https://github.com/Azganoth/tree-sitter-lua")
    (make "https://github.com/alemuller/tree-sitter-make")
    (markdown "https://github.com/ikatyang/tree-sitter-markdown")
    (perl "https://github.com/tree-sitter-perl/tree-sitter-perl")
    (python "https://github.com/tree-sitter/tree-sitter-python")
    (r "https://github.com/r-lib/tree-sitter-r")
    (rust "https://github.com/tree-sitter/tree-sitter-rust")
    (toml "https://github.com/tree-sitter/tree-sitter-toml")
    (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
    (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
    (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; Eglot configuration
(with-eval-after-load 'eglot
	;; C/C++ language server
	(add-to-list 'eglot-server-programs '((c-ts-mode c++-ts-mode) "clangd-17"))
	;; Python language server config
	(setq-default eglot-workspace-configuration
		'(:pylsp (:plugins (:pycodestyle (:enabled :json-false)
							   :pyflakes (:enabled :json-false)
							   :flake8 (:enabled t))
					 :configurationSources ["flake8"]))))

;;;; General configuration
;; make auto-generated emacs custom configurations land in another
;; file rather then our own init.el
(setq custom-file "~/.emacs.d/custom.el")
;;; Load external files before anything else
(load-file custom-file)
(load-file "~/.emacs.d/funcs.el")
(load-file "~/.emacs.d/linux-kernel.el")

;; Autocompletion for on find-files (and M-x with smex)
(ido-mode 1)
;; Show line number on the left
(global-display-line-numbers-mode)
;; Remove menu, scroll and tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)
;; Enable spell checking on orgmode with flyspell, builtin to emacs
(add-hook 'org-mode-hook #'flyspell-mode)
;; GTAG configuration
(add-hook 'c-ts-mode-hook (lambda () (ggtags-mode 1)))
(setq-local imenu-create-index-function #'ggtags-build-imenu-index)

;; Company-mode (complete anything) configuration
(setq company-backends (delete 'company-semantic company-backends))
(add-to-list 'company-backends 'company-c-headers)

;; Load theme
(load-theme 'zenburn t)

;; set default font for XEmacs
(set-face-attribute 'default nil :font "JetBrains Mono-11")
(set-frame-font "JetBrains Mono-11" nil t)

;; autofill automatically in all modes
(setq-default auto-fill-function 'do-auto-fill)
;; and make it more than the usual, letting the linters handle the
;; warnings and the auto-indent can happen with M-q
(set-fill-column 120)

;; kbd remapping
(global-set-key (kbd "M-o") 'open-line-below)
(global-set-key (kbd "M-O") 'open-line-above)
(global-set-key (kbd "M-z") 'zap-up-to-char)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-,") 'duplicate-line)

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)
(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)
(define-key ggtags-navigation-mode-map (kbd "C-c g q") 'ggtags-navigation-mode-done)

(with-eval-after-load 'c-ts-mode
	(define-key c-ts-mode-map [(tab)] 'company-complete)
	(define-key c++-ts-mode-map [(tab)] 'company-complete)
	(define-key c-ts-mode-map (kbd "M-q") 'eglot-format)
	(define-key c++-ts-mode-map (kbd "M-q") 'eglot-format))

;;;;; init.el ends here
