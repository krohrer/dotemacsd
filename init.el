(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'load-path "~/.emacs.d/site-lisp/tuareg-mode")
(require 'tuareg)

(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme")
(require 'color-theme)
(color-theme-initialize)

(add-to-list 'load-path "/opt/local/share/emacs/site-lisp/w3m")
(require 'w3m-load)

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(require 'omake-mode)

(add-to-list 'load-path "~/.emacs.d/personal")
(require 'kmr-generic)
(require 'kmr-tuareg)
;;; (require 'kmr-omake)
(require 'kmr-latex)
(require 'kmr-color-theme-library)

(if (boundp 'window-system)
    (kmr-color-theme-chnuschper))
