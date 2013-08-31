;; shift in  = switch to red ribbon
;; shift out = switch to black ribbon

(defgroup ribbon-faces nil
  "Faces for emulating a red-black ribbon typewriter.")

(defface ribbon-red-face
  '((t :inherit error))
  "Ribbon mode face to use for text punched with the red ribbon."
  :group 'ribbon-faces)

(defconst ribbon-switch-to-red-char "")

(defconst ribbon-switch-to-black-char "")

(defconst ribbon-switch-char-regexp
  (regexp-opt (list ribbon-switch-to-red-char
                    ribbon-switch-to-black-char)))

(defun ribbon-update-property (start end)
  (save-excursion
    (goto-char start)
    (let ((span-start start)
          (current-ribbon 'black))
      (while (search-forward-regexp ribbon-switch-char-regexp end t)
        (put-text-property span-start (match-beginning 0)
                           'ribbon current-ribbon)
        (setq span-start (match-end 0))
        (setq current-ribbon
              (cond ((string-equal (match-string 0)
                                   ribbon-switch-to-red-char)
                     'red)
                    ((string-equal (match-string 0)
                                   ribbon-switch-to-black-char)
                     'black))))
      (put-text-property span-start end
                         'ribbon current-ribbon))))

(ert-deftest ribbon-test-update-property ()

  (with-temp-buffer
    (insert "abcdef")
    (ribbon-update-property (point-min) (point-max))
    (should (eq (get-text-property 4 'ribbon) 'black)))
  
  (with-temp-buffer
    (insert "abc")
    (insert ribbon-switch-to-red-char)
    (insert "def")
    (ribbon-update-property (point-min) (point-max))
    (should (eq (get-text-property 1 'ribbon) 'black))
    (should (eq (get-text-property 7 'ribbon) 'red)))

  (with-temp-buffer
    (insert "ab")
    (insert ribbon-switch-to-red-char)
    (insert "cd")
    (insert ribbon-switch-to-black-char)
    (insert "ef")
    (ribbon-update-property (point-min) (point-max))
    (should (eq (get-text-property 1 'ribbon) 'black))
    (should (eq (get-text-property 4 'ribbon) 'red))
    (should (eq (get-text-property 7 'ribbon) 'black))))
