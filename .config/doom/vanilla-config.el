;;; vanilla-config.el --- Base config for Emacs
;;; Commentary:
;;; Author: Ali Ghahraei Figueroa
;;; Code:

;;;; Recipes


(defun doom--get-modules (file)
  "Doom config diff"
  (unless (file-exists-p file)
    (user-error "%s does not exist" file))
  (with-temp-buffer
    (insert-file-contents file)
    (when (re-search-forward "(doom! " nil t)
      (goto-char (match-beginning 0))
      (cdr (sexp-at-point)))))

(defun doom--put-modules (tmpfile modules)
  (with-temp-file tmpfile
    (delay-mode-hooks (emacs-lisp-mode))
    (insert (replace-regexp-in-string " " "\n" (prin1-to-string modules)))
    (indent-region (point-min) (point-max))))

;;;###autoload
(defun doom/what-has-changed ()
  "Open an ediff session to compare the module list in
~/.emacs.d/init.example.el and ~/.doom.d/init.el."
  (interactive)
  (let ((old-modules (doom--get-modules (expand-file-name "init.example.el" doom-emacs-dir)))
        (new-modules (doom--get-modules (expand-file-name "init.el" doom-private-dir)))
        (example-init-el "/tmp/doom-init.example.el")
        (private-init-el "/tmp/doom-private-init.el"))
    (doom--put-modules example-init-el old-modules)
    (doom--put-modules private-init-el new-modules)
    (ediff private-init-el example-init-el)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Clean Whitespace and Save Buffer                                                                                                ;; ;;
;; (defvar whitespace-cleanup-p t                                                                                                      ;; ;;
;;   "Whether `clean-and-save-buffer' should also call `whitespace-cleanup'.")                                                         ;; ;;
;;                                                                                                                                     ;; ;;
;; (defun clean-and-save-buffer ()                                                                                                     ;; ;;
;;   "Call `whitespace-cleanup' and save current buffer with `save-buffer' if `whitespace-cleanup-p' is non-nil, otherwise just save." ;; ;;
;;   (interactive)                                                                                                                     ;; ;;
;;   (if whitespace-cleanup-p                                                                                                          ;; ;;
;;       (progn (whitespace-cleanup)                                                                                                   ;; ;;
;;              (save-buffer))                                                                                                         ;; ;;
;;     (save-buffer)))                                                                                                                 ;; ;;
;;                                                                                                                                     ;; ;;
;; (global-set-key (kbd "s-s") 'clean-and-save-buffer)                                                                                 ;; ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Smooth scrolling                                                     ;;
;; (setq mouse-wheel-scroll-amount '(2 ((shift) . 1)) ; Two lines at a time ;;
;;       mouse-wheel-progressive-speed nil ; No acceleration                ;;
;;       mouse-wheel-follow-mouse t ; Scroll window under mouse             ;;
;;       )                                                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Python interpreter                                             ;;
;; (cond ((eq system-type 'darwin)                                    ;;
;;        (defvar python-shell-interpreter "/usr/local/bin/python3")) ;;
;;       (t                                                           ;;
;;        (defvar python-shell-interpreter "/usr/bin/python")))       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; Web browser                                                       ;;
;; (cond ((eq system-type 'darwin)                                       ;;
;;        (setq browse-url-generic-program "open"                        ;;
;;              browse-url-browser-function (quote browse-url-generic))) ;;
;;       (t                                                              ;;
;;        (setq browse-url-browser-function 'browse-url-firefox)))       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;; Miscellaneous configuration
;;; Definitions:

;; (defalias 'yes-or-no-p 'y-or-n-p); Prompt only as y/n

(defun rename-file-and-buffer ()
  "Rename the current buffer and the file it is visiting."
  (interactive)
  (if (not (and buffer-file-name (file-exists-p buffer-file-name)))
      (message "Buffer is not visiting a file!")
    (let ((new-file-name (read-file-name "New name: " buffer-file-name)))
      (cond
       ((vc-backend buffer-file-name) (vc-rename-file buffer-file-name new-file-name))
       (t
        (rename-file buffer-file-name new-file-name t)
        (set-visited-file-name new-file-name t t))))))

(defun kill-matching-buffers-just-do-it ()
  "Like `kill-matching-buffers', but without asking."
  (interactive)
  (cl-letf (((symbol-function 'kill-buffer-ask) #'kill-buffer))
    (call-interactively #'kill-matching-buffers)))


(setq ;; fill-column 100
      confirm-kill-emacs nil
      ;; indicate-buffer-boundaries nil
      ;; vc-follow-symlinks t
      backup-directory-alist '(("." . "~/.emacs.d/backup")))


;;; Setup
;; (delete-selection-mode t) ; Allow selected text deletion
;; (add-hook 'json-mode-hook (lambda ()
;;                             (setq js-indent-level 2)))


(provide 'vanilla-config)
;;; vanilla-config.el ends here
