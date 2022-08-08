;;; packages-config.el --- Packages config for Emacs
;;; Author: Ali Ghahraei Figueroa
;;; Commentary:
;;; Code:

;;;; Current

;;; Configuration
(use-package! fish-mode
  :hook fish-mode)


(use-package! ox-hugo
  :after ox)


(after! python-pytest
  (advice-add 'python-pytest--run :before
              (lambda (&rest args)
                "Integrate with poetry"
                (setq python-pytest-executable "poetry run pytest"))))


(add-hook! python-mode
  (lsp))


(after! tramp
  ;; Adapted from YADM's manpage (https://github.com/TheLocehiliosan/yadm)
  (add-to-list 'tramp-methods
               '("dotfiles"
                 (tramp-login-program "enter-dotfiles")
                 (tramp-login-args (("/bin/sh")))
                 (tramp-remote-shell "/bin/sh")
                 (tramp-remote-shell-args ("-c")))))


(map! :leader
      (:prefix-map ("z" . "unclassified")
       (:when (and (featurep! :tools magit) (featurep! :ui workspaces))
        :desc "Dotfiles' magit status" "d"
        (cmd! (+workspace/new "dotfiles")
              (magit-status "/dotfiles::")))))


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


(use-package! beacon
  :init
  (beacon-mode 1))


(when (featurep! :term vterm)
  (setq vterm-always-compile-module t)
  (advice-add '+vterm/toggle :before
              (lambda (&rest args)
                "Compile vterm-module.so if missing

If you only set `vterm-always-compile-module' without the advice, it will
only compile instead of compiling and then running `+vterm/toggle'.
"
                (unless (require 'vterm-module nil t)
                  (when (condition-case nil
                            (vterm-module-compile)
                          (error nil))
                    (delete-windows-on " *Install vterm* "))))))
