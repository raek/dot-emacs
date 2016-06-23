(defvar gpj-mode-hook nil)

(defvar gpj-mode-map
  (let ((map (make-keymap)))
    ;; (define-key map (kbd "C-j") 'newline-and-indent)
    map))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.gpj\\'" . gpj-mode))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.opt\\'" . gpj-mode))

(defun gpj-wrap-with-brackets (re)
  (concat "\\_<\\[" re "\\]\\_>"))

(defconst gpj-file-type-regexp
  (let ((file-types
         '("Auto Include"
           "Library"
           "Merged Library"
           "Program"
           "Project"
           "Referemce"
           "Relocatable Object"
           "Select One"
           "Shared Object"
           "Singleton Library"
           "Subproject"
           "Text"
           "INTEGRITY Application")))
    (gpj-wrap-with-brackets (regexp-opt file-types))))

(defconst gpj-font-lock-keywords
  (list
   '("^#!gbuild$" . font-lock-preprocessor-face)
   '("^#component\\_>.*" . font-lock-preprocessor-face)
   '("#" . font-lock-comment-delimiter-face)
   '("#\\(.*\\)" 1 font-lock-comment-face)
   '("^macro\\_>" . font-lock-keyword-face)
   '("^macro\\s-+\\(\\(\\w\\|\\s_\\)+\\)=" 1 font-lock-variable-name-face)
   '("^\\(\\(\\w\\|\\s_\\)+\\)=" 1 font-lock-variable-name-face)
   (cons (concat "^" gpj-file-type-regexp) 'font-lock-function-name-face)
   (cons gpj-file-type-regexp 'font-lock-type-face)
   (cons (gpj-wrap-with-brackets ".*?") 'font-lock-warning-face)
   '("\\$\\(\\w\\|\\s_\\)+" . font-lock-constant-face)
   '("\\%\\(\\w\\|\\s_\\)+" . font-lock-builtin-face)
   '("\\${.*?}" . font-lock-constant-face)
   '("\\$(.*?)" . font-lock-constant-face)
   '("^\\s-+\\(:\\(\\w\\|\\s_\\)+\\)" 1 font-lock-builtin-face)
   )
  "Default highlighting expressions for gpj-mode")

(defvar gpj-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?$ "." st)
    (modify-syntax-entry ?& "." st)
    (modify-syntax-entry ?* "." st)
    (modify-syntax-entry ?+ "." st)
    (modify-syntax-entry ?- "." st)
    (modify-syntax-entry ?< "." st)
    (modify-syntax-entry ?> "." st)
    (modify-syntax-entry ?/ "." st)
    (modify-syntax-entry ?\" "." st)
    (modify-syntax-entry ?= "." st)
    (modify-syntax-entry ?# "<" st)
    (modify-syntax-entry ?\n ">" st)
    (modify-syntax-entry ?\( "()" st)
    (modify-syntax-entry ?\) ")(" st)
    (modify-syntax-entry ?{ "(}" st)
    (modify-syntax-entry ?} "){" st)
    (modify-syntax-entry ?\[ "_" st)
    (modify-syntax-entry ?\] "_" st)
    st)
  "Syntax table for gpj-mode")

(defun gpj-mode ()
  "Major mode for editing Green Hills project files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table gpj-mode-syntax-table)
  (use-local-map gpj-mode-map)
  (set (make-local-variable 'font-lock-defaults)
       '(gpj-font-lock-keywords t))
  ;; (set (make-local-variable 'indent-line-function)
  ;;      '(gpj-indent-line))
  (make-local-variable 'comment-start)
  (setq comment-start "#")
  (setq major-mode 'gpj-mode)
  (setq mode-name "GPJ")
  (run-hooks 'gpj-mode-hook)
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  )

(provide 'gpj-mode)
