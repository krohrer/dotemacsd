(provide 'kmr-omake)

(require 'make-mode)

(setq auto-mode-alist (cons '("OMake\\(file\\|root\\)\\|\\.om" . kmr-makefile-omake-mode) auto-mode-alist))

(defvar kmr-makefile-omake-mode-syntax-table 
  (let ((st (copy-syntax-table makefile-mode-syntax-table)))
    (modify-syntax-entry ?\` "." st)
    (modify-syntax-entry ?\' "." st))
  st)

(define-derived-mode kmr-makefile-omake-mode makefile-mode "OMakefile"
  "An adapted `makefile-mode' that knows about omake."
  :syntax-table kmr-makefile-omake-mode-syntax-table)