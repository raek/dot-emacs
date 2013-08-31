(setq custom-file (concat user-emacs-directory "custom-file.el"))
(load custom-file)

(require 'cl)

(defmacro dowith (destr-var action &rest qlist)
  (let ((list-symbol (make-symbol "list"))
        (var-symbol (make-symbol "var")))
    `(let ((,list-symbol (backquote ,qlist)))
       (dolist (,var-symbol ,list-symbol)
         (destructuring-bind ,destr-var ,var-symbol
           ,action)))))

(require 'package)

(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))

(package-initialize)

(add-to-list 'load-path (concat user-emacs-directory "lisp"))

(fset 'my-complete-lisp-symbol
      (make-hippie-expand-function '(try-complete-lisp-symbol-partially
                                     try-complete-lisp-symbol)))

(dowith load-file
    (load (concat user-emacs-directory "init-" load-file ".el"))
  "bindings"
  "lisp"
  )
