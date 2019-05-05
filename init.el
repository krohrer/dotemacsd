(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; Load color theme library
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme")
(require 'color-theme)
(color-theme-initialize)

;;; ocp-indent
(add-to-list 'load-path "/Users/krohrer/.opam/4.03.0/share/emacs/site-lisp")
(require 'ocp-indent)

;;; Customize Tuareg-mode
(defun tuareg-font-lock-hook ()
   (font-lock-add-keywords nil
    '(("\\<\\(raise\\|exit\\|assert\\w*\\|fail\\w+\\)\\>"
       1 font-lock-warning-face prepend))))
;(remove-hook 'tuareg-mode-hook #'tuareg-font-lock-hook)
(add-hook 'tuareg-mode-hook #'tuareg-font-lock-hook)

;;; Load additional modes
(add-to-list 'load-path "~/.emacs.d/site-lisp")

(add-to-list 'auto-mode-alist '("\\.md" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.markdown" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))

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

(global-set-key (kbd "§")
		(lambda (&optional arg)
		  (interactive "p")
		  (insert "_")))

(global-set-key (kbd "±")
		(lambda (&optional arg)
		  (interactive "p")
		  (insert "->")))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;; Add melpa repositories for 
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))


;; Quick merlin setup for EMACS
;; https://github.com/the-lambda-church/merlin
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))

(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
;; Load merlin-mode
(require 'merlin)
;; Start merlin on ocaml files
(add-hook 'tuareg-mode-hook 'merlin-mode t)
(add-hook 'caml-mode-hook 'merlin-mode t)
;; Enable auto-complete
(setq merlin-use-auto-complete-mode 'easy)
;; Use opam switch to lookup ocamlmerlin binary
(setq merlin-command 'opam)

(add-hook 'tuareg-mode-hook 'merlin-mode)
