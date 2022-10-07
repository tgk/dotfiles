(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (and (< emacs-major-version 24) nil)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

;;(add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; use ivy
;;(use-package ivy
;;             (ivy-mode 1))

(ivy-mode 1)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(setq ruby-insert-encoding-magic-comment nil)

(global-set-key (kbd "C-x g") 'magit-status)

;;(print "Setting up autocomplete")
;;(require 'auto-complete-config)
;;(require 'ac-nrepl)
;;(ac-config-default)
;;(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
;;(add-hook 'cider-mode-hook 'ac-nrepl-setup)
;;(eval-after-load "auto-complete"
;;  '(add-to-list 'ac-modes 'cider-repl-mode))

(print "Adding hooks")
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojurescript-mode-hook 'paredit-mode)
;(setq cider-repl-pop-to-buffer-on-connect nil)

(require 'highlight-parentheses)
(add-hook 'clojure-mode-hook
  (lambda ()
    (highlight-parentheses-mode t)))

;; Key binding to use "hippie expand" for text autocompletion
;; http://www.emacswiki.org/emacs/HippieExpand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))


;; key bindings for cider interaction
(defun cider-reset ()
  (interactive)
  (cider-interactive-eval (format "(user/reset)")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ivy-mode t)
 '(package-selected-packages
   '(add-node-modules-path prettier-js restclient auto-complete ac-cider cider vue-mode ag magit ac-nrepl))
 '(safe-local-variable-values '((projectile-project-type . lein-test))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(eval-after-load 'cider
  '(progn
     (define-key cider-mode-map (kbd "C-c r") 'cider-reset)))

(setq-default indent-tabs-mode nil)

(standard-display-ascii ?\t "^I")

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

;; theme

(load-theme 'tangotango t)

;; to not be teased, turn off tool-bar and menu-bar

(tool-bar-mode -1)
(menu-bar-mode -1)

;; ag / projectile
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; js indent
(setq js-indent-level 2)

(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'vue-mode-hook 'prettier-js-mode)

(eval-after-load 'web-mode
    '(progn
       (add-hook 'web-mode-hook #'add-node-modules-path)
       (add-hook 'web-mode-hook #'prettier-js-mode)))
