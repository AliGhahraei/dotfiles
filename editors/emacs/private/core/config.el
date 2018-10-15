;;; config.el --- description -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(def-package! elpy
  :hook (python-mode . elpy-mode)
  :config
  (setq elpy-test-runner 'elpy-test-pytest-runner)
  (setq elpy-rpc-python-command "python3"))

;;; config.el ends here
