(require 'package)
(package-initialize)

(defun installedp (name)
  (member name (mapcar #'car package-alist)))

(setq packages-to-install '(
  better-defaults
  buffer-move
  git-commit-mode
  paredit
  smex
  ))

(dolist (package packages-to-install)
    (if (installedp package)
        (message "Package '%s' already installed." package)
      (progn (message "Installing package '%s'..." package)
             (package-install package))))