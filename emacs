;; package management

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'load-path "~/.emacs.d/vendor/")

;; color schemes

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'tomorrow-night t)

;; Interactively Do Things

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; show buffer files vertically instead of horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

;; backup files

(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

(setq delete-old-versions t)
(setq kept-old-versions 10)
(setq kept-new-versions 25)

;; org mode

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; hooks

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; misc

(set-variable 'scroll-bar-mode nil)

(add-to-list 'load-path "~/.emacs.d/vendor/expand-region.el/")
(require 'expand-region)

;; C-k at beginning of line takes whole line including newline
(setq kill-whole-line t)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;;
;; key mappings
;;

(define-key global-map (kbd "RET") 'newline-and-indent)

(define-key global-map (kbd "C-=") 'er/expand-region)

;;
;; modes
;;

;; coffeescript

(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)

(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook
	  '(lambda () (coffee-custom)))

;; haml

(require 'haml-mode)

;; jade

(add-to-list 'load-path "~/.emacs.d/vendor/jade-mode")
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; markdown

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(setq auto-mode-alist
      (cons '("\\.markdown" . markdown-mode) (cons '("\\.md" . markdown-mode) auto-mode-alist)))

;; sass

(add-to-list 'load-path "~/.emacs.d/vendor/sass-mode")
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

;;
;; added by emacs
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("935e766f12c5f320c360340c8d9bc1726be9f8eb01ddeab312895487e50e5835" "870bd363bb2770316775ffa6e5938d73bee3adaba1f4d5b7b129533b3e0fed41" default)))
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(ns-command-modifier (quote meta))
 '(ns-right-command-modifier (quote super))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
