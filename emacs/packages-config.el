;;; packages-config.el --- Packages config for Emacs
;;; Author: Ali Ghahraei Figueroa
;;; Commentary: Personal Emacs' packages config. Base Emacs setup is handled elsewhere
;;; Code:

;; Reminder: Don't use ensure here to avoid breaking spacemacs
(use-package ivy
  :config
  (global-set-key (kbd "s-b") 'ivy-switch-buffer))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x)) ; Read all shell variables if running in a
    (exec-path-from-shell-initialize)))  ; supported os

(use-package flycheck
  :config
  (setq flycheck-python-flake8-executable "/usr/local/bin/python3"))


(provide 'packages-config)
;;; packages-config.el ends here
