;;; init --- INIT Emacs file
;;; Commentary:
;;; Code:

;;;; Load external files before anything else
(load "~/.emacs.d/custom.el")
(load "~/.emacs.d/funcs.el")

(autoload 'slime "~/quicklisp/slime-helper.el" "Launch SLIME" t nil)
(setq-default inferior-lisp-program "sbcl")

;;;; Package/plugin management
(require 'package)

;; package manager custom repos
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; Certify to install 'use-package' package to manage default packages
;; that should be installed in the startup
(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))
(eval-when-compile
  (require 'use-package))

;; Install minimum set of generic plugins
; Tmux powerline
(use-package powerline
  :ensure t
  :init (powerline-default-theme))
; Git commands from emacs
(use-package magit
  :ensure t)
; Syntax checker to replace flymake, which is bundled with emacs
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
; Autocomplete with LSP support
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1))

;; Language specific package
(use-package python
  :ensure t
  :hook ((python-ts-mode . eglot-ensure)
	 (python-ts-mode . company-mode))
  :mode (("\\.py$" . python-ts-mode)))	; for some reason it's not working

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
    (go "https://github.com/tree-sitter/tree-sitter-go")
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

;; eglot (emacs builtin) configuration
(setq-default eglot-workspace-configuration
              '(:pylsp (:plugins (:rope_autoimport (:enabled t)))))

;;;; General configuration
;; Show line number on the left
(global-display-line-numbers-mode)

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
;;
;;;;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(eglot zenburn-theme xcscope use-package powerline magit flycheck editorconfig)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
