(provide 'kmr-color-theme-library)

(eval-when-compile (require 'color-theme))

(defun kmr-color-theme-chnuschper ()
  "Color theme by Kaspar Rohrer, created 2008-12-10. Based on color-theme-deep-blue."
  (interactive)
  (color-theme-install
   '(kmr-color-theme-chnuschper
     ((background-color . "#051e3e")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "red")
      (foreground-color . "#eeeeee")
      (mouse-color . "white"))
     ((compilation-message-face . underline)
      (goto-address-mail-face . italic)
      (goto-address-mail-mouse-face . secondary-selection)
      (goto-address-url-face . bold)
      (goto-address-url-mouse-face . highlight)
      (list-matching-lines-buffer-name-face . underline)
      (list-matching-lines-face . secondary-selection)
      (rmail-highlight-face . rmail-highlight)
      (view-highlight-face . highlight)
      (widget-mouse-face . highlight))
     ;(default ((t (:stipple nil :background "#051e3e" :foreground "#eeeeee" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 116 :width normal :family "adobe-courier"))))
     (Info-title-1-face ((t (:bold t :weight bold :height 1.728 :family "helv"))))
     (Info-title-2-face ((t (:bold t :weight bold :height 1.44 :family "helv"))))
     (Info-title-3-face ((t (:bold t :weight bold :height 1.2 :family "helv"))))
     (Info-title-4-face ((t (:bold t :weight bold :family "helv"))))
     (bold ((t (:bold t :weight bold))))
     (bold-italic ((t (:italic t :bold t :slant italic :weight bold))))
     (border ((t (:background "black"))))
     (buffer-menu-buffer ((t (:bold t :weight bold))))
     ;(button ((t (:underline t))))
     (button ((t (:bold t :weight bold :foreground "cyan"))))
     (calendar-today-face ((t (:background "blue"))))
     (change-log-acknowledgement-face ((t (:italic t :foreground "CadetBlue" :slant italic))))
     (change-log-conditionals-face ((t (:foreground "SeaGreen2"))))
     (change-log-date-face ((t (:foreground "burlywood"))))
     (change-log-email-face ((t (:foreground "SeaGreen2"))))
     (change-log-file-face ((t (:bold t :foreground "goldenrod" :weight bold))))
     (change-log-function-face ((t (:foreground "SeaGreen2"))))
     (change-log-list-face ((t (:bold t :foreground "DeepSkyBlue1" :weight bold))))
     (change-log-name-face ((t (:foreground "gold"))))
     (comint-highlight-input ((t (:bold t :weight bold))))
     (comint-highlight-prompt ((t (:foreground "cyan"))))
     (compilation-column-number ((t (:foreground "CadetBlue1"))))
     (compilation-error ((t (:foreground "yellow"))))
     (compilation-info ((t (:bold t :foreground "Green1" :weight bold))))
     (compilation-line-number ((t (:foreground "SeaGreen2"))))
     (compilation-warning ((t (:bold t :foreground "Orange" :weight bold))))
     (completions-common-part ((t (:family "adobe-courier" :width normal :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "#eeeeee" :background "#051e3e" :stipple nil :height 116))))
     (completions-first-difference ((t (:bold t :weight bold))))
     (cursor ((t (:background "red" :foreground "white"))))
     (cvs-filename-face ((t (:foreground "lightblue"))))
     (cvs-handled-face ((t (:foreground "pink"))))
     (cvs-header-face ((t (:bold t :foreground "lightyellow" :weight bold))))
     (cvs-marked-face ((t (:bold t :foreground "green" :weight bold))))
     (cvs-msg-face ((t (:italic t :slant italic))))
     (cvs-need-action-face ((t (:foreground "orange"))))
     (cvs-unknown-face ((t (:foreground "red"))))
     (diary-face ((t (:foreground "orange red"))))
     (diff-added-face ((t (nil))))
     (diff-changed-face ((t (nil))))
     (diff-context-face ((t (:foreground "grey70"))))
     (diff-file-header-face ((t (:bold t :background "grey60" :weight bold))))
     (diff-function-face ((t (:foreground "grey70"))))
     (diff-header-face ((t (:background "grey45"))))
     (diff-hunk-header-face ((t (:background "grey45"))))
     (diff-index-face ((t (:bold t :background "grey60" :weight bold))))
     (diff-nonexistent-face ((t (:bold t :background "grey60" :weight bold))))
     (diff-removed-face ((t (nil))))
     (escape-glyph ((t (:foreground "cyan"))))
     (file-name-shadow ((t (:foreground "grey70"))))
     (fixed-pitch ((t (:family "fixed"))))
     (font-latex-bold-face ((t (:bold t :foreground "OliveDrab" :weight bold))))
     (font-latex-italic-face ((t (:italic t :foreground "OliveDrab" :slant italic))))
     (font-latex-math-face ((t (:foreground "burlywood"))))
     (font-latex-sedate-face ((t (:foreground "LightGray"))))
     (font-latex-string-face ((t (:foreground "LightSalmon"))))
     (font-latex-warning-face ((t (:bold t :foreground "Pink" :weight bold))))
     (font-lock-builtin-face ((t (:foreground "DeepSkyBlue1")))) ;LightCoral
     (font-lock-comment-delimiter-face ((t (:foreground "HotPink1" :italic t :slant italic))))
     (font-lock-comment-face ((t (:foreground "HotPink1" :italic t :slant italic)))) ; :italic t :slant italic
     (font-lock-constant-face ((t (:foreground "DeepSkyBlue1"))))
     (font-lock-doc-face ((t (:foreground "HotPink1" :bold nil :weight normal)))) ;BlanchedAlmond
     (font-lock-doc-string-face ((t (:foreground "HotPink1" :bold nil :weight normal)))) ;BlanchedAlmond
     (font-lock-function-name-face ((t (:bold t :foreground "goldenrod" :weight bold))))
     (font-lock-keyword-face ((t (:bold t :foreground "DeepSkyBlue1" :weight bold))))
     (font-lock-negation-char-face ((t (nil))))
     (font-lock-preprocessor-face ((t (:foreground "gold"))))
     (font-lock-reference-face ((t (:foreground "LightCoral"))))
     (font-lock-regexp-grouping-backslash ((t (:bold t :weight bold))))
     (font-lock-regexp-grouping-construct ((t (:bold t :weight bold))))
     (font-lock-string-face ((t (:foreground "LawnGreen"))))
     (font-lock-type-face ((t (:foreground "Green" :slant italic :underline nil)))) ; CadetBlue1
     (font-lock-variable-name-face ((t (:foreground "SeaGreen2"))))
     (font-lock-warning-face ((t (:bold t :foreground "orangered" :weight bold))))
     (tuareg-font-lock-error-face ((t (:bold t :background "red" :foreground "yellow" :weight bold))))
     (tuareg-font-lock-governing-face ((t (:bold t :weight bold :foreground "DeepSkyBlue1"))))
     (tuareg-font-lock-interactive-error-face ((t (:foreground "yellow"))))
     (tuareg-font-lock-interactive-output-face ((t (:foreground "cyan"))))
     (tuareg-font-lock-multistage-face ((t (:bold t :background "lightgray" :foreground "darkblue" :weight bold))))
     (tuareg-font-lock-operator-face ((t (:bold t :weight bold :foreground "DeepSkyBlue1"))))
     (fringe ((t (:background "#102e4e"))))
     (header-line ((t (:background "grey20" :foreground "grey90" :box nil))))
     ;(help-argument-name ((t (:italic t :slant italic))))
     (help-argument-name ((t (:bold t :weight bold :foreground "DeepSkyBlue1"))))
     (highlight ((t (:background "darkgreen"))))
     (holiday-face ((t (:foreground "green"))))
     (ido-first-match ((t (:bold t :weight bold))))
     (ido-incomplete-regexp ((t (:foreground "yellow"))))
     (ido-indicator ((t (:background "red1" :foreground "yellow1" :width condensed))))
     (ido-only-match ((t (:foreground "ForestGreen"))))
     (ido-subdir ((t (:foreground "red1"))))
     (info-header-node ((t (:foreground "DeepSkyBlue1"))))
     (info-header-xref ((t (:bold t :foreground "SeaGreen2" :weight bold))))
     (info-menu-5 ((t (:foreground "wheat"))))
     (info-menu-header ((t (:bold t :weight bold :family "helv"))))
     (info-node ((t (:foreground "DeepSkyBlue1"))))
     (info-xref ((t (:bold t :foreground "SeaGreen2" :weight bold))))
     (isearch ((t (:background "palevioletred2" :foreground "brown4"))))
     (italic ((t (:italic t :slant italic))))
     (lazy-highlight ((t (:background "paleturquoise4"))))
     (link ((t (:foreground "cyan1" :underline t))))
     (link-visited ((t (:underline t :foreground "violet"))))
     (match ((t (:background "RoyalBlue3"))))
     (menu ((t (:background "gray" :foreground "black" :family "helvetica"))))
     (minibuffer-prompt ((t (:foreground "cyan"))))
     (mode-line ((t (:background "white" :foreground "black" :box (:line-width 2 :style released-button)))))
     (mode-line-buffer-id ((t (:foreground "black" :box (:line-width 1 :style released-button)))))
     (mode-line-highlight ((t (:box (:line-width 1 :color "grey40" :style released-button)))))
     (mode-line-inactive ((t (:background "#051020" :foreground "grey80" :box (:line-width 1 :color "#051020" :style released-button) :weight light))))
     (modeline-mousable ((t (:background "grey" :foreground "black" :box (:line-width 2 :style released-button)))))
     (modeline-mousable-minor-mode ((t (:background "yellow" :foreground "black" :box (:line-width 2 :style released-button)))))
     (mouse ((t (:background "white"))))
     (next-error ((t (:background "DarkCyan"))))
     (nobreak-space ((t (:foreground "cyan" :underline t))))
     (query-replace ((t (:foreground "brown4" :background "palevioletred2"))))
     (region ((t (:inverse-video t))))
     (scroll-bar ((t (:background "gray" :foreground "#506070"))))
     (secondary-selection ((t (:background "yellow" :foreground "gray10"))))
     (shadow ((t (:foreground "grey70"))))
     (show-paren-match-face ((t (:bold t :background "#020f1f" :foreground "yellow" :weight bold))))
     (show-paren-mismatch-face ((t (:bold t :background "#020f1f" :foreground "red" :weight bold))))
     (paren-face-match-light ((t (:background "#020f1f"))))
     (paren-face-match ((t (:background "#051e3e"))))
     (paren-face-mismatch ((t (:bold t :foreground "red" :background "#020f1f":weight bold))))
     (paren-face-no-match ((t (:bold t :foreground "red" :background "#020f1f" :weight bold))))
     (speedbar-button-face ((t (:foreground "green3"))))
     (speedbar-directory-face ((t (:foreground "light blue"))))
     (speedbar-file-face ((t (:foreground "cyan"))))
     (speedbar-highlight-face ((t (:background "sea green"))))
     (speedbar-selected-face ((t (:foreground "red" :underline t))))
     (speedbar-separator-face ((t (:background "blue" :foreground "white" :overline "gray"))))
     (speedbar-tag-face ((t (:foreground "yellow"))))
     (tool-bar ((t (:background "grey75" :foreground "black" :box (:line-width 1 :style released-button)))))
     (tooltip ((t (:background "lightyellow" :foreground "black"))))
     (trailing-whitespace ((t (:background "#051e3e"))))
     (underline ((t (:underline t))))
     (variable-pitch ((t (:family "helv"))))
     (vertical-border ((t (nil))))
     (widget-button ((t (:bold t :weight bold))))
     (widget-button-pressed ((t (:foreground "red"))))
     (widget-documentation ((t (:foreground "lime green"))))
     (widget-field ((t (:background "dim gray"))))
     (widget-inactive ((t (:foreground "light gray"))))
     (widget-single-line-field ((t (:background "dim gray")))))))

(add-to-list 'color-themes '(kmr-color-theme-chnuschper  "Chnuschper (Winter Blues)" "Kaspar Rohrer"))
