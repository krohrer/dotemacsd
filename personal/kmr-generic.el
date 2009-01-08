(provide 'kmr-generic)

(ido-mode 1)
(menu-bar-mode -1)
(column-number-mode 1)
(scroll-bar-mode -1)

; Either :
(transient-mark-mode -1)
; or :
(show-paren-mode 1)

(global-set-key [f1] (lambda () (interactive) (manual-entry (current-word))))
(global-set-key [?\C-=] (lambda () (interactive) (other-window 1)))
(global-set-key [?\M-=] (lambda () (interactive) (other-window -1)))

; Automatically strip ^M from shell output, like omake build system.
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
