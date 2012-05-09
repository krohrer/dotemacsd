(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;(add-to-list 'load-path "~/.emacs.d/site-lisp/tuareg-mode")
;(require 'tuareg)

(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme")
(require 'color-theme)
(color-theme-initialize)

(add-to-list 'load-path "~/.emacs.d/site-lisp")

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-to-list 'load-path "~/.emacs.d/personal")
(require 'kmr-generic)
;(require 'kmr-tuareg)
(require 'kmr-latex)
(require 'kmr-color-theme-library)
(require 'kmr-omake)

(if (and (boundp 'window-system) (not (null window-system)))
    (kmr-color-theme-chnuschper))
