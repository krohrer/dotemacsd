(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; Load color theme library
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme")
(require 'color-theme)
(color-theme-initialize)

;;; Customize Tuareg-mode
(setq tuareg-use-smie nil)
(load "~/.emacs.d/site-lisp/tuareg/tuareg-site-file")
(defun tuareg-font-lock-hook ()
   (font-lock-add-keywords nil
    '(("\\<\\(raise\\|exit\\|assert\\w*\\|fail\\w*\\)\\>"
       1 font-lock-warning-face prepend))))
;(remove-hook 'tuareg-mode-hook #'tuareg-font-lock-hook)
(add-hook 'tuareg-mode-hook #'tuareg-font-lock-hook)

;;; Load additional modes
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;(autoload 'js2-mode "js2" nil t)
;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))

(load "~/.emacs.d/site-lisp/htmlize.el")

;;; Load personal customization
(add-to-list 'load-path "~/.emacs.d/personal")
(require 'kmr-generic)
(require 'kmr-color-theme-library)

(if (and (boundp 'window-system)
	 (not (null window-system)))
    (progn
      (kmr-color-theme-chnuschper)))

;;; Customization for Mac OS X
(if (fboundp 'ns-find-file)
    (global-set-key [ns-drag-file] 'ns-find-file))
(if  (fboundp 'ns-pop-up-frames)
    (ns-pop-up-frames nil))

;;; Bind Control-Tab to insert tab
(global-set-key (kbd "<C-tab>")
		(lambda (&optional arg) "Keyboard macro."
		  (interactive "p")
		  (kmacro-exec-ring-item (quote ([17 tab] 0 "%d"))
					 arg)))
