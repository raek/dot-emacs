(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))
(package-initialize)
(package-refresh-contents)

(defun installedp (name)
  (member name (mapcar #'car package-alist)))

(setq packages-to-install '(
  better-defaults
  buffer-move
  git-commit-mode
  magit
  paredit
  smex
  ))

(dolist (package packages-to-install)
    (if (installedp package)
        (message "Package '%s' already installed." package)
      (progn (message "Installing package '%s'..." package)
             (package-install package))))
