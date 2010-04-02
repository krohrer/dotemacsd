;; Turn on syntax coloring for all files
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-cursor-mode t)
 '(inhibit-startup-screen t)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 5) ((control)))))
 '(paren-match-face (quote paren-face-match-light))
 '(paren-sexp-mode t)
 '(show-paren-style (quote expression))
 '(time-stamp-format "%U, %3a %3b %2d %02H:%02M:%02S %Z %:y")
 '(truncate-partial-width-windows nil)
 '(tuareg-library-path "/opt/local/lib/ocaml"))

;; Set regular expression rules for syntax coloring
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "Red" :foreground "white")))))
