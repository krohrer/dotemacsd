(provide 'kmr-generic)

(global-set-key [?\C-z] nil)
(global-set-key [f1] (lambda () (interactive) (manual-entry (current-word))))
(global-set-key [?\C-=] (lambda () (interactive) (other-window 1)))
(global-set-key [?\M-=] (lambda () (interactive) (other-window -1)))

; Automatically strip ^M from shell output, like omake build system.
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)

