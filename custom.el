;; Turn on syntax coloring for all files
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-mailto-function nil)
 '(column-number-mode t)
 '(htmlize-output-type (quote inline-css))
 '(ido-mode (quote both) nil (ido))
 '(inhibit-startup-screen t)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 5) ((control)))))
 '(ns-alternate-modifier (quote none))
 '(ns-command-modifier (quote meta))
 '(org-agenda-files (quote ("~/Documents/Orgs")))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(time-stamp-format "%U, %3a %3b %2d %02H:%02M:%02S %Z %:y")
 '(tool-bar-mode nil)
 '(truncate-partial-width-windows t)
 '(tuareg-interactive-scroll-to-bottom-on-output t))

;; Set regular expression rules for syntax coloring
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#051e3e" :foreground "#eeeeee" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Monaco"))))
 '(cursor ((t (:background "Red" :foreground "white")))))
