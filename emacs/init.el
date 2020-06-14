;;; init --- INIT Emacs file
;;; Commentary:
;;; Code:

(require 'package)
;; bad interaction with ibus (input method) make it necessary to get
;; deadkey chars to get printed on XEmacs (GUI)
(require 'iso-transl)

;; load external files
(load "~/.emacs.d/custom.el")
(load "~/.emacs.d/funcs.el")
(load (expand-file-name "~/quicklisp/slime-helper.el"))

(setq inferior-lisp-program "sbcl")

;; package manager custom repos
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" .
                                 "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; certify to install 'use-package' package to manage default packages
;; that should be installed in the startup
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(use-package magit
    :ensure t)
(use-package editorconfig
    :ensure t
    :config (editorconfig-mode 1))
(use-package flycheck
    :ensure t
    :init (global-flycheck-mode))
(use-package powerline
    :ensure t
    :init (powerline-default-theme))
(use-package emmet-mode
	:ensure t
	:init (emmet-mode))

;; Show line number on the left
(setq linum-format "%d ")
(global-linum-mode 1)

;; Load theme
(load-theme 'tango-dark)

;; set default font for XEmacs
(set-face-attribute 'default nil :font "Bitstream Vera Sans Mono-9")
(set-frame-font "Bitstream Vera Sans Mono-9" nil t)

;; autofill automatically in all modes
(setq-default auto-fill-funtion 'do-auto-fill)

(add-hook 'sqml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

;; kbd remapping
(global-set-key (kbd "M-o") 'open-line-below)
(global-set-key (kbd "M-O") 'open-line-above)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
	'(package-selected-packages
		 (quote
			 (emmet-mode web-mode rpm-spec-mode yaml-mode company ac-slime helm-slime slime xcscope markdown-mode powerline use-package python-mode projectile magit helm flycheck evil-visual-mark-mode editorconfig))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
