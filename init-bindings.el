(defun raek-dired-containing-directory ()
  (interactive)
  (dired "."))

(defun raek-dired-mode-hook ()
  (local-set-key (kbd "<C-backspace>") 'dired-up-directory))

(add-hook 'dired-mode-hook 'raek-dired-mode-hook)

(autoload 'buf-move-up    "buffer-move")
(autoload 'buf-move-down  "buffer-move")
(autoload 'buf-move-left  "buffer-move")
(autoload 'buf-move-right "buffer-move")

(dowith (key . command)
    (global-set-key (kbd key) command)



  ;; Smex
  ("M-x" . smex)
  ("M-X" . smex-major-mode-commands)
  ;; This is your old M-x.
  ("C-c C-c M-x" . execute-extended-command)

  ;; Complete word from text in buffer.
  ("<backtab>" . dabbrev-expand)

  ;; Align point to beginning of words on the previous line.
  ("M-§" . indent-relative)

  ;; Switch to the other window
  ("§" . other-window)

  ;; Switch to other window by arrow key
  ("<S-up>"    . windmove-up)
  ("<S-down>"  . windmove-down)
  ("<S-left>"  . windmove-left)
  ("<S-right>" . windmove-right)

  ;; Swap the current buffer into another window
  ("<C-S-up>"    . buf-move-up)
  ("<C-S-down>"  . buf-move-down)
  ("<C-S-left>"  . buf-move-left)
  ("<C-S-right>" . buf-move-right)

  ;; Switch to next and previous buffers in "window history" (like in
  ;; a browser)
  ("<M-left>"  . previous-buffer)
  ("<M-right>" . next-buffer)

  ;; Visit directory above current file or directory
  ("<C-backspace>" . raek-dired-containing-directory)



  ;; The rest are from emacs-starter-kit

  ;; It's all about the project.
  ("C-c f" . find-file-in-project)

  ;; You know, like Readline.
  ("C-M-h" . backward-kill-word)

  ;; Completion that uses many different methods to find options.
  ("M-/" . hippie-expand)

  ;; Perform general cleanup.
  ("C-c n" . esk-cleanup-buffer)

  ;; Turn on the menu bar for exploring new modes
  ("C-<f10>" . menu-bar-mode)

  ;; Font size
  ;;(define-key global-map (kbd "C-+") 'text-scale-increase)
  ;;(define-key global-map (kbd "C--") 'text-scale-decrease)

  ;; Use regex searches by default.
  ("C-s" . isearch-forward-regexp)
  ("\C-r" . isearch-backward-regexp)
  ("M-%" . query-replace-regexp)
  ("C-M-s" . isearch-forward)
  ("C-M-r" . isearch-backward)
  ("C-M-%" . query-replace)

  ;; Jump to a definition in the current file. (Protip: this is awesome.)
  ("C-x C-i" . imenu)

  ;; File finding
  ("C-x M-f" . ido-find-file-other-window)
  ("C-c y" . bury-buffer)
  ("C-c r" . revert-buffer)

  ;; Window switching. (C-x o goes to the next window)
  ;;(windmove-default-keybindings) ;; Shift+direction
  ("C-x O" . ,(lambda () (interactive) (other-window -1))) ;; back one
  ("C-x C-o" . ,(lambda () (interactive) (other-window 2))) ;; forward two

  ;; Start eshell or switch to it if it's active.
  ("C-x m" . eshell)

  ;; Start a new eshell even if one is active.
  ("C-x M" . ,(lambda () (interactive) (eshell t)))

  ;; Start a regular shell if you prefer that.
  ("C-x C-m" . shell)

  ;; If you want to be able to M-x without meta (phones, etc)
  ("C-c x" . execute-extended-command)

  ;; Help should search more than just commands
  ;;(define-key 'help-command "a" 'apropos)

  ;; Should be able to eval-and-replace anywhere.
  ("C-c e" . esk-eval-and-replace)

  ;; M-S-6 is awkward
  ("C-c q" . join-line)

  ;; So good!
  ("C-c g" . magit-status)
  )
