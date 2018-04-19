;;; config.el --- Base config for Emacs
;;; Author: Ali Ghahraei Figueroa
;;; Commentary:
;;; Code:

(defalias 'yes-or-no-p 'y-or-n-p); Prompt only as y/n

(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))) ;; two lines at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq browse-url-browser-function 'browse-url-firefox)
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
(setq vc-follow-symlinks t)

(global-set-key (kbd "s-s") (lambda ()
                              (interactive)
                              (whitespace-cleanup)
                              (save-buffer)))

(delete-selection-mode 1); Allow selected text deletion

(desktop-save-mode 1)


(defun rename-file-and-buffer ()
  "Rename the current buffer and the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

;;; config.el ends here


;;; Legacy options
;; (tool-bar-mode -1)

;; (menu-bar-mode -1); Desactiva el menú

;; (setq inhibit-startup-message t); Adiós a la pantalla de inicio

;; (setq custom-safe-themes t); Desactiva la verificación de tema

;; (electric-pair-mode 1); Que la inserción de paréntesis comience

;; (set-face-attribute 'default nil :height 130); Cambia la fuente

;; (setq-default tab-width 4)
;; (add-hook 'prog-mode-hook (lambda ()
;;                             (defvar c-basic-offset 4)
;;                             (setq tab-width 4)))

;; (defadvice save-buffers-kill-emacs (around no-y-or-n activate)
;;   "Allow Emacs to close even if there are unsaved buffers."
;;   (cl-flet ((yes-or-no-p (&rest args) t)
;;             (y-or-n-p (&rest args) t))
;;     ad-do-it))

;; (setq visible-bell 1)

;; (global-set-key (kbd "<wheel-right>") (lambda () (interactive)))
;; (global-set-key (kbd "<mouse-6>") (lambda () (interactive)))
;; (global-set-key (kbd "<wheel-left>") (lambda () (interactive))); Arregla el error del scrolleo

;; (setq initial-scratch-message (format ";; LISP, motherfucker, do you speak it?\n"))

;; (global-set-key (kbd "C-x M-k") 'kill-buffer)

;; (global-set-key (kbd "C-x k") 'kill-this-buffer)

;; (global-auto-revert-mode t); Reload files when changed


