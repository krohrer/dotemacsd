(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme")
(require 'color-theme)
(color-theme-initialize)

;(setq tuareg-use-smie t)
(load "~/.emacs.d/site-lisp/tuareg/tuareg-site-file")

;(add-to-list 'auto-mode-alist '("\\.ml[iylp]?$" . caml-mode))
;(autoload 'caml-mode "caml" "Major mode for editing OCaml code." t)
;(autoload 'run-caml "inf-caml" "Run an inferior OCaml process." t)
;(autoload 'camldebug "camldebug" "Run ocamldebug on program." t)
;(add-to-list 'interpreter-mode-alist '("ocamlrun" . caml-mode))
;(add-to-list 'interpreter-mode-alist '("ocaml" . caml-mode))
;(add-to-list 'load-path "~/.emacs.d/site-lisp/caml-mode")

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-to-list 'load-path "~/.emacs.d/personal")
(require 'kmr-generic)
;(require 'kmr-tuareg)
;(require 'kmr-omake)
;(require 'kmr-latex)
(require 'kmr-color-theme-library)

(if (and (boundp 'window-system)
	 (not (null window-system)))
    (progn
      (kmr-color-theme-chnuschper)
      (require 'caml-font)))

(if (fboundp 'ns-find-file)
    (global-set-key [ns-drag-file] 'ns-find-file))

(if  (fboundp 'ns-pop-up-frames)
    (ns-pop-up-frames nil))

(global-set-key (kbd "<C-tab>") (lambda (&optional arg) "Keyboard macro."
				  (interactive "p")
				  (kmacro-exec-ring-item (quote ([17 tab] 0 "%d"))
							 arg)))
