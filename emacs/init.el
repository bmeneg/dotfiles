;; Reduce emacs startup time by decreasing the about of gc done
(setq gc-cons-threshold (* 10 1000 1000))
(add-hook 'emacs-start-hook
	  #'(lambda ()
	      (message "Startup in %s sec with %d garbage collections"
		       (emacs-init-time "%.2f")
		       gcs-done)))

;;; Load external files before anything else
(load "~/.emacs.d/custom.el")
(load "~/.emacs.d/funcs.el")

(autoload 'slime "~/quicklisp/slime-helper.el" "Launch SLIME" t nil)
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
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc
					     )))

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
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history nil))

;; File manager
(use-package posframe
  :ensure t)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t)))
  :bind
  (:map global-map
	("M-0" . treemacs-select-window)
	("C-x t 1" . treemacs-delete-other-windows)
	("C-x t t" . treemacs)
	("C-x t d" . treemacs-select-directory)
	("C-x t B" . treemacs-bookmark)
	("C-x t C-t" . treemacs-find-file)
	("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-icons-dired
  :ensure t
  :hook (dired-mode . treemacs-icons-dired-enabled-once))

(use-package treemacs-magit
  :ensure t
  :after (treemacs magit))

(use-package all-the-icons
  :ensure t)

(use-package treemacs-all-the-icons
  :ensure t
  :after (all-the-icons))

;; Language specific package
(use-package python
  :hook ((python-ts-mode . company-mode)
	 (python-ts-mode . eglot-ensure))
  :mode (("\\.py\\'" . python-ts-mode)))

(use-package go-mode
  :hook ((go-ts-mode . company-mode)
	 (go-ts-mode . eglot-ensure))
  :mode (("\\.go\\'" . go-ts-mode)))

(use-package sh-mode
  :hook ((bash-ts-mode . company-mode)
	 (bash-ts-mode . eglot-ensure))
  :mode (("\\.sh\\'" . bash-ts-mode)))

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
(setq-default eglot-workspace-configuration
              '(:pylsp (:plugins (:pycodestyle (:enabled :json-false)
					       :pyflakes (:enabled :json-false)
                                               :flake8 (:enabled t))
                                 :configurationSources ["flake8"])))

;;;; General configuration
;; Show line number on the left
(global-display-line-numbers-mode)
;; Remove menu, scroll and tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)
;; Enable spell checking on orgmode with flyspell, builtin to emacs
(add-hook 'org-mode-hook #'flyspell-mode)

;; Load theme
(load-theme 'zenburn t)

;; set default font for XEmacs
(set-face-attribute 'default nil :font "JetBrains Mono-10")
(set-frame-font "JetBrains Mono-10" nil t)

;; autofill automatically in all modes
(setq-default auto-fill-function 'do-auto-fill)

;; kbd remapping
(global-set-key (kbd "M-o") 'open-line-below)
(global-set-key (kbd "M-O") 'open-line-above)
(global-set-key (kbd "M-z") 'zap-up-to-char)

;;;;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(treemacs-magit treemacs markdown-mode powerline use-package python-mode projectile magit helm flycheck evil-visual-mark-mode editorconfig)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
