;;; config.el --- Base config for Emacs
;;; Author: Ali Ghahraei Figueroa
;;; Commentary: Personal base Emacs config. Package setup is handled elsewhere
;;; Code:


;;;; Definitions and global variables:
(defalias 'yes-or-no-p 'y-or-n-p); Prompt only as y/n

(defun create-article (filename)
  "Create a new pelican article with default content. Prompt for a filename using `read-file-name'."
  (interactive (list (read-file-name "Article filename: " "~/g/personal-website/content/")))
  (find-file filename)
  (insert (format "#+TITLE: \n#+DATE: %s\n#+PROPERTY: SUMMARY "
                  (format-time-string "%Y-%m-%d")))
  (beginning-of-buffer)
  (move-end-of-line nil))

(defun clean-and-save-buffer ()
  "Call `whitespace-cleanup' and save current buffer with `save-buffer' if
`whitespace-cleanup-p' is non-nil, otherwise just save."
  (interactive)
  (if whitespace-cleanup-p
      (progn (whitespace-cleanup)
             (save-buffer))
    (save-buffer)))

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

(defvar whitespace-cleanup-p t
  "Whether `clean-and-save-buffer' should also call `whitespace-cleanup'.")

(setq mouse-wheel-scroll-amount '(2 ((shift) . 1)) ; Two lines at a time
      mouse-wheel-progressive-speed nil ; No acceleration
      mouse-wheel-follow-mouse t ; Scroll window under mouse

      fill-column 100
      backup-directory-alist '(("." . "~/.emacs.d/backup"))
      indicate-buffer-boundaries nil
      vc-follow-symlinks t)

(cond ((eq system-type 'darwin)
       (setq browse-url-generic-program "open"
             browse-url-browser-function (quote browse-url-generic)
             python-shell-interpreter "/usr/local/bin/python3"))
      (t
       (setq browse-url-browser-function 'browse-url-firefox
             python-shell-interpreter "/usr/bin/python")))


;;;; Key bindings
(global-set-key (kbd "s-s") 'clean-and-save-buffer)


;;;; Setup
(delete-selection-mode t) ; Allow selected text deletion
(add-hook 'json-mode-hook (lambda ()
                            (setq js-indent-level 2)))
(toggle-frame-maximized)


(provide 'config)
;;; config.el ends here
