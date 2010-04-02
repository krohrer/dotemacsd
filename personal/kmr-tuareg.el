
;;;; Kaspar Rohrer, Thu Jan 15 01:58:13 CET 2009

(provide 'kmr-tuareg)

(eval-when-compile (require 'tuareg))
(eval-when-compile (require 'time-stamp))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Integration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
;(remove-hook 'tuareg-mode-hook #'tuareg-hook)
(add-hook 'tuareg-mode-hook #'tuareg-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun tuareg-hook ()
  "Customizes the Tuareg major mode to my liking"
  (interactive)
  (local-set-key "" 'tuareg-browse-library)
  (local-set-key "" 'tuareg-goto-module-at-point)
  (local-set-key "u" 'comment-or-uncomment-region)
  (local-set-key "h" 'kmr-tuareg-insert-header)
  (local-set-key "d" 'kmr-tuareg-insert-ocamldoc)
  (local-set-key "s" 'kmr-tuareg-insert-short-separator)
  (local-set-key "l" 'kmr-tuareg-insert-long-separator))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Font-locking (and poppin')
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defface tuareg-font-lock-mutator-face
  '((t (:underline t)))
  ""
  :group 'tuareg-faces)

(defun tuareg-font-lock-hook ()
   (font-lock-add-keywords nil
    '(("\\<\\(raise\\|failwith\\|exit\\|assert\\|assert_\\w+\\|fail_\\w+\\)\\>"
       1 font-lock-warning-face prepend)
      ("\\<\\(\\w\\|[_]\\)+\\([']\\)\\>"
       2 font-lock-warning-face prepend))))

;(remove-hook 'tuareg-mode-hook #'tuareg-font-lock-hook)
(add-hook 'tuareg-mode-hook #'tuareg-font-lock-hook)

;;; (defun tuareg-search-mutator ()
;;;   ""
;;;   (interactive)
;;;   (re-search-forward "\\<\\(\\(\\w\\|[_]\\)+[']\\)\\>"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Commenting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar kmr-tuareg-separator-short-length 40 
  "Length of a short separator comment. See \\[kmr-tuareg-insert-separator]")

(defvar kmr-tuareg-separator-long-length 80
  "Length of a long separator comment. See \\[kmr-tuareg-insert-separator]")

(defun kmr-tuareg-insert-header (&optional short-p)
  "Prepends the current buffer with an OCaml comment that
includes the current time and username"
  (interactive)
  (insert "(* " (time-stamp-string) " *)\n"))

(defun kmr-tuareg-insert-ocamldoc ()
  "Inserts an ocamldoc comment."
  (interactive)
  (insert "(**  *)")
  (backward-char 3))

(defun kmr-tuareg-insert-separator (cols)
  "Inserts a separator comment, which occupies `cols' columns, to
break up the text."
  (interactive "NHow many columns should the seaparator occupy: ")
  (insert "(*" (make-string (- cols 4) ?-) "*)\n"))

(defun kmr-tuareg-insert-short-separator ()
  "Inserts a short separator. Equivalent to (\\[kmr-tuareg-insert-separator] `kmr-tuareg-short-separator')."
  (interactive)
  (kmr-tuareg-insert-separator kmr-tuareg-separator-short-length))

(defun kmr-tuareg-insert-long-separator ()
  "Inserts a long separator. Equivalent to (\\[kmr-tuareg-insert-separator] `kmr-tuareg-long-separator')."
  (interactive)
  (kmr-tuareg-insert-separator kmr-tuareg-separator-long-length))

