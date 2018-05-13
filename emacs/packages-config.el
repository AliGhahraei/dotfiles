;;; packages-config.el --- Packages config for Emacs
;;; Author: Ali Ghahraei Figueroa
;;; Commentary: Personal packages config. Base Emacs setup is handled elsewhere
;;; Notes: Don't use ensure in this package to avoid breaking spacemacs
;;; Code:

(with-eval-after-load 'ivy
  (global-set-key (kbd "s-b") 'ivy-switch-buffer))

(with-eval-after-load 'counsel
  (global-set-key (kbd "s-;") 'counsel-git-grep))

(with-eval-after-load 'counsel-projectile
  (global-set-key (kbd "s-f") 'counsel-projectile-find-file))

(with-eval-after-load 'magit
  (global-set-key (kbd "s-g") 'magit-status))

(with-eval-after-load 'flycheck
  (setq flycheck-python-pylint-executable "/usr/local/bin/python3"))

(with-eval-after-load 'circe
  (setq circe-network-options
        `(("Freenode"
          :nick "Nonbeliever"
          :channels (:after-auth "#archlinux")
          :nickserv-password ,freenode-password))))

(with-eval-after-load 'evil-mc
  (global-evil-mc-mode  1)

  (defun evil--mc-make-cursor-at-col (startcol _endcol orig-line)
    (move-to-column startcol)
    (unless (= (line-number-at-pos) orig-line)
      (evil-mc-make-cursor-here)))
  (defun evil-mc-make-vertical-cursors (beg end)
    (interactive (list (region-beginning) (region-end)))
    (evil-mc-pause-cursors)
    (apply-on-rectangle #'evil--mc-make-cursor-at-col
                        beg end (line-number-at-pos (point)))
    (evil-mc-resume-cursors)
    (evil-normal-state)
    (move-to-column (evil-mc-column-number (if (> end beg)
                                               beg
                                             end)))))

(with-eval-after-load 'restclient
  (defvar restclient-response-vars '()
    "List used to store response variables to extract. It is used by
`restclient-extract-var'")

  (defun restclient-extract-var (var)
    (add-to-list 'restclient-response-vars var))

  (add-hook 'restclient-response-received-hook
            (lambda ()
              (save-excursion
                (save-match-data
                  (dolist (var 'restclient-response-vars)
                    (when (re-search-forward
                           (format "\"%s\":\"\\(.*?\\)\"" var) nil t)
                      (set var (match-string 1)))))))))

(provide 'packages-config)
;;; packages-config.el ends here
