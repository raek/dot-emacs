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

(condition-case nil
    (load (concat user-emacs-directory "init-local"))
  (file-error 'skipped))

(add-to-list 'load-path (concat user-emacs-directory "lisp"))

(dowith load-file
    (load (concat user-emacs-directory "init-" load-file))
  "bindings"
  "lisp"
  )

(server-start)
