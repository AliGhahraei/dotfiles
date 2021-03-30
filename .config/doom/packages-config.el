;;; packages-config.el --- Packages config for Emacs
;;; Author: Ali Ghahraei Figueroa
;;; Commentary:
;;; Code:

;;;; Current

;;; Configuration
(use-package! fish-mode
  :hook fish-mode)


(after! python-pytest
  (advice-add 'python-pytest--project-root :around
              (lambda (original-function &rest args)
                "Return SUBPROJECT envvar if defined, otherwise apply normally."
                (let ((subproject (or (getenv "SUBPROJECT")
                                      (apply original-function args))))
                  subproject)))

  (advice-add 'python-pytest--run :before
              (lambda (&rest args)
                "Set pytest executable to PYTHONPATH if set"
                (setq python-pytest-executable
                      (if-let ((pythonpath (getenv "PYTHONPATH")))
                          (concat "PYTHONPATH=" pythonpath " " "pytest")
                        "pytest")))))


(after! tramp
  ;; From YADM's manpage
  (add-to-list 'tramp-methods
               '("yadm"
                 (tramp-login-program "yadm")
                 (tramp-login-args (("enter")))
                 (tramp-remote-shell "/bin/sh")
                 (tramp-remote-shell-args ("-c")))))


(map! :leader
      (:prefix-map ("a" . "applications")
       (:when (and (featurep! :tools magit) (featurep! :ui workspaces))
        :desc "YADM magit status" "y"
        (cmd! (+workspace/new "yadm")
              (magit-status "/yadm::")))))


(after! magit
  ;; Based on https://emacs.stackexchange.com/a/35812
  (defun kill-diff-buffer-in-repo-and-delete-windows (&rest _)
    "Delete magit diff buffer related to current repo"
    (let ((magit-diff-buffer-in-current-repo
           (magit-mode-get-buffer 'magit-diff-mode)))
      (kill-buffer magit-diff-buffer-in-current-repo))
    (delete-other-windows))

  (add-hook! 'git-commit-setup-hook
    (defun add-kill-magit-diff-finish-hook ()
      (add-hook! 'with-editor-post-finish-hook :local
                 #'kill-diff-buffer-in-repo-and-delete-windows))
    (defun add-kill-magit-diff-cancel-hook ()
      (add-hook! 'with-editor-post-cancel-hook :local
                 #'kill-diff-buffer-in-repo-and-delete-windows))))


(after! org
  (setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled))



;;;; Obsolete:

;;; Configuration

;; (use-package! elpy
;;   :hook (python-mode . elpy-mode)
;;   :config
;;   (setq elpy-test-runner 'elpy-test-pytest-runner)
;;   (setq elpy-rpc-python-command "python3"))

;; (with-eval-after-load 'flycheck
;;   (if (eq system-type 'darwin)
;;       (setq flycheck-python-flake8-executable "/usr/local/bin/python3")
;;     (setq flycheck-python-flake8-executable "/usr/bin/python")))


;; (with-eval-after-load 'circe
;;   (setq auth-sources '("~/.ircauth.gpg"))

;;   (defun fetch-password (&rest params)
;;     "Fetch a password using auth-source (Copied from the Circe wiki: URL
;; `https://github.com/jorgenschaefer/circe/wiki/Configuration#safer-password-management')"
;;     (require 'auth-source)
;;     (let ((match (car (apply 'auth-source-search params))))
;;       (if match
;;           (let ((secret (plist-get match :secret)))
;;             (if (functionp secret)
;;                 (funcall secret)
;;               secret))
;;         (error "Password not found for %S" params))))

;;   (setq circe-network-options
;;         '(("Freenode"
;;            :nick "Nonbeliever"
;;            :channels (:after-auth "#archlinux")
;;            :nickserv-password (lambda (server)
;;                                 (fetch-password :machine server))))))


;; (with-eval-after-load 'evil-mc
;;   (global-evil-mc-mode  1)

;;   (defun evil--mc-make-cursor-at-col (startcol _endcol orig-line)
;;     (move-to-column startcol)
;;     (unless (= (line-number-at-pos) orig-line)
;;       (evil-mc-make-cursor-here)))
;;   (defun evil-mc-make-vertical-cursors (beg end)
;;     (interactive (list (region-beginning) (region-end)))
;;     (evil-mc-pause-cursors)
;;     (apply-on-rectangle #'evil--mc-make-cursor-at-col
;;                         beg end (line-number-at-pos (point)))
;;     (evil-mc-resume-cursors)
;;     (evil-normal-state)
;;     (move-to-column (evil-mc-column-number (if (> end beg)
;;                                                beg
;;                                              end)))))


;; (with-eval-after-load 'restclient
;;   (defvar restclient-response-vars '()
;;     "List used to store response variables to extract. It is used by `req-var'")

;;   (defun req-var (req-var-name &optional var-name)
;;     (add-to-list 'restclient-response-vars
;;                  `(,(or var-name req-var-name) ,req-var-name))
;;     nil)

;;   (defun --extract-req-vars ()
;;     "Extract variables specified in `restclient-response-vars'"
;;     (save-excursion
;;       (save-match-data
;;         (dolist (var-and-req-var restclient-response-vars)
;;           (let ((var-name (car var-and-req-var)) (req-var-name (cadr var-and-req-var)))
;;             (message (buffer-name)
;;             (when (re-search-forward
;;                    (format "\"%s\":\ *\"(.*?)\"" req-var-name) nil t)
;;               (set var-name (match-string 1)))))))))

;;   (add-hook 'restclient-response-received-hook '--extract-req-vars))


;;; Key bindings

;; (global-set-key (kbd "s-b") 'ivy-switch-buffer)
;; (global-set-key (kbd "s-;") 'counsel-git-grep)
;; (global-set-key (kbd "s-a") 'counsel-projectile-find-file)
;; (global-set-key (kbd "s-z") 'ido-kill-buffer)
;; (global-set-key (kbd "s-g") 'magit-status)


(provide 'packages-config)
;;; packages-config.el ends here
