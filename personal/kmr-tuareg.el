(provide 'kmr-tuareg)

(eval-when-compile (require 'tuareg))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auxiliary functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'kmr-ocaml-ssep [return ?( ?* escape ?3 ?6 ?- ?* ?) tab return])
(fset 'kmr-ocaml-lsep [return ?( ?* escape ?7 ?6 ?- ?* ?) tab return])
(fset 'kmr-ocaml-template [?( ?* ?  ?$ ?I ?d ?$ ?  ?* ?) return return ?( ?* escape ?7 ?6 ?- ?* ?) return return ?( ?* escape ?7 ?6 ?- ?* ?) return])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
;(remove-hook 'tuareg-mode-hook #'tuareg-hook)
(add-hook 'tuareg-mode-hook #'tuareg-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun tuareg-hook ()
  "Customizes the Tuareg major mode to my liking"
  (interactive)
  (local-set-key "" 'tuareg-browse-library)
  (local-set-key "" 'tuareg-browse-library)
  (local-set-key "" 'tuareg-goto-module-at-point))

(defun tuareg-extract-qualified-identifer-at-point ()
  "Extracts the identifier at point, including any module
identiers (separated by a period) that prefix it. Returns a list
with containing the identifiers in order of occurence."
  (interactive)
  (save-excursion
    (re-search-backward "[^_[:word:]\.]")
    (re-search-forward "\\([_[:word:]]+\\.\\)*[_[:word:]]+")
    (let* ((qualified-id (match-string-no-properties 0))
	   (identifiers (split-string qualified-id "\\.")))
      identifiers)))

(defun tuareg-goto-identifer (prefix ident)
  "TODO"
  (let ((definition (concat prefix (regexp-quote ident))))
    (if (or (re-search-backward definition nil t)
	    (re-search-forward definition nil t))
	(progn (recenter nil) t)
      nil)))

(defun tuareg-module-file-name (module &optional path ext)
  "TODO"
  (setq path (if path (file-name-as-directory path) ""))
  (concat path
	  (downcase (substring module 0 1))
	  (substring module 1)
	  (or ext ".mli")))

;; Interactive testing:
;; (tuareg-module-file-name "TeTeTe")
;; (tuareg-module-file-name "TeTeTe" "some/path")
;; (tuareg-module-file-name "TeTeTe" "some/path/" ".ml")

(defvar tuareg-file-history nil)

(defun tuareg-goto-module-file (module &optional dir)
  "TODO"
  (interactive "MModule name: ")
  (let ((file))
    (unless dir
      (setq dir (read-string "Module directory: " 
			     (if tuareg-file-history
				 nil
				 tuareg-library-path )
			     'tuareg-file-history)))
    (unless (and (file-directory-p dir)
		 (file-readable-p dir))
      (error "Could not read directory: " dir))
    (setq file (tuareg-module-file-name module dir))
    (unless (file-readable-p file)
      (error (format "Could not read module file: %s" file)))
    (find-file-other-window file)))

(defun tuareg-goto-module-at-point ()
  "TODO: Use `tuareg-file-history'"
  (interactive)
  (let ((ids (tuareg-extract-qualified-identifer-at-point)))
    (tuareg-goto-module-file (car ids) tuareg-library-path)
    (search-forward (regexp-quote (cadr ids)))))

(defun tuareg-goto-definition ()
  "
Get qualified itentifier at point
If more than one identifier:
- Extract all module qualifiers

If only one identifier


2 Parts:
- Make module filename (path and module name)
- Visit module file

"
  (error "NYI"))

(defconst tuareg-definitions-regexp
  "\\<\\(and\\|val\\|type\\|module\\|class\\|exception\\|let\\)\\>"
  "Regexp matching definition phrases.")

(defconst tuareg-definitions-bind-skip-regexp
  (concat "\\<\\(rec\\|type\\|virtual\\)\\>\\|'[" tuareg-alpha "][0-9_'"
	  tuareg-alpha "]*\\|('.*)")
  "Regexp matching stuff to ignore after a binding keyword.")

;; (defconst tuareg-declaration-re-prefix "let[[:space:]]+")
;; (defconst tuareg-definition-re-prefix "val[[:space:]]+")

;; (defun tuareg-goto-definition ()
;;   ""
;;   (interactive)
;;   (let* ((qualifieds (tuareg-extract-qualified-identifer-at-point))
;; 	 (ident (last qualifieds)))
;;     (tuareg-find-identier *tuareg-declaration-re-prefix* ident)))



(defface tuareg-font-lock-mutator-face
  '((t (:underline t)))
  ""
  :group 'tuareg-faces)

(defun tuareg-font-lock-hook ()
   (font-lock-add-keywords nil
    '(("\\<\\(raise\\|failwith\\|exit\\|assert\\|assert_\\w+\\|fail_\\w+\\)\\>"
       1 font-lock-warning-face prepend)
      ("\\<\\(\\(\\w\\|[_]\\)+[']\\)\\>"
       1 font-lock-warning-face prepend)
)))

(remove-hook 'tuareg-mode-hook #'tuareg-font-lock-hook)
(add-hook 'tuareg-mode-hook #'tuareg-font-lock-hook)

(add-hook 'tuareg-mode-hook 'tuareg-font-lock-hook)

(defun tuareg-search-mutator ()
  ""
  (interactive)
  (re-search-forward "\\<\\(\\(\\w\\|[_]\\)+[']\\)\\>"))