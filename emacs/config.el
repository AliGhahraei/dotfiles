;;; config.el --- Base config for Emacs
;;; Author: Ali Ghahraei Figueroa
;;; Commentary: Personal base emacs config. Package setup is handled elsewhere
;;; Code:


;;;; Definitions and Global Variables:
(defalias 'yes-or-no-p 'y-or-n-p); Prompt only as y/n

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

(defun clean-and-save-buffer ()
  "Call `whitespace-cleanup' and save the current buffer with `save-buffer'"
  (interactive)
  (whitespace-cleanup)
  (save-buffer))

(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))) ;; two lines at a time
(setq mouse-wheel-progressive-speed nil) ;; No acceleration
(setq mouse-wheel-follow-mouse t) ;; scroll window under mouse

(setq browse-url-browser-function 'browse-url-firefox)
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
(setq vc-follow-symlinks t)
(setq desktop-save t)


;;;; Key Bindings
(global-set-key (kbd "s-s") 'clean-and-save-buffer)


;;;; Setup
(delete-selection-mode t); Allow selected text deletion

(desktop-save-mode t)

(provide 'config)
;;; config.el ends here
