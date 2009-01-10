;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Usage

; in .emacs:
;   (add-to-list 'load-path "THE DIRECTORY THIS ELISP EXISTS")
;   (require 'omake-mode)
;   ; key bindings (jfuruse's setting)
;   (global-unset-key "\M-P") ; Shift+Alt+p 
;   (global-unset-key "\M-N") ; Shift+Alt+n
;   (global-unset-key "\M-o") ; Alt+o
;   (global-unset-key "\M-O") ; Shift+Alt+o
;   (global-set-key "\M-P" 'omake-previous-error)
;   (global-set-key "\M-N" 'omake-next-error)
;   (global-set-key "\M-o" 'omake-round-visit-buffer)
;   (global-set-key "\M-O" 'omake-run)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Configurables

; omake path and args
(defconst omake-program-path "/usr/bin/omake")
(defconst omake-program-arguments "-P -w -j 3")

; sounds
(defconst omake-sound-success "..../...wav")
(defconst omake-sound-error "..../...wav")
(defconst omake-sound-start "..../...wav")

; colors
(defconst omake-error-highlight-background "#FFFF00")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'font-lock)

(defconst omake-buffer-name "*omake*")
(defconst omake-buffer-pattern "^\*omake\*")
(defconst omake-misc-buffer-name "*omake-misc*")

(defconst omake-error-regexp "File.*line.*characters [0-9]+-[0-9]+")
(defconst omake-progress-regexp "\\[\\([= ]+\\|saved \\.omakedb[= ]*\\)\\] [0-9]+ / [0-9]+\n")
(defconst omake-directory-regexp "\\(Entering\\|Leaving\\) directory `\\(.*\\)'")
(defconst omake-report-regexp "\\*\\*\\* omake:.*")
(defconst omake-rebuild-regexp "\\*\\*\\* omake: \\(rebuilding\\|reading OMakefiles\\)")
(defconst omake-locked-regexp "\\*\\*\\* omake: waiting for project lock:")

; overlay
(setq omake-overlay-log nil)
(setq omake-overlay-source nil)

(defun omake-create-overlay ()
  (let ((overlay (make-overlay 1 1 nil)))
    (make-face 'omake-face)
    (set-face-doc-string 'omake-face "face for omake highlight")
    (set-face-background 'omake-face omake-error-highlight-background)
    (overlay-put overlay 'face 'omake-face)
    overlay))

(defun omake-display-overlay-log (buffer start end)
  (interactive)
  (if (not (overlayp omake-overlay-log))
      (setq omake-overlay-log (omake-create-overlay)))
  (move-overlay omake-overlay-log start end buffer))

(defun omake-display-overlay-source (buffer start end)
  (interactive)
  (if (not (overlayp omake-overlay-source))
      (setq omake-overlay-source (omake-create-overlay)))
  (move-overlay omake-overlay-source start end buffer))

; CR jfuruse: use the variable above!
(defconst omake-font-lock-keywords
  (list 
   (cons omake-error-regexp font-lock-warning-face)
   (cons omake-progress-regexp font-lock-doc-face)
   (cons omake-directory-regexp font-lock-function-name-face)
   (cons omake-report-regexp font-lock-type-face)))


(defun omake-fold (f st lst)
  (if lst (omake-fold f (funcall f st (car lst)) (cdr lst))
      st))

; oh shit, we really have no recursion in elisp
; (defun omake-filter (p lst)
;   (if lst
;       (if (funcall p (car lst))
;           (cons (car lst) (omake-filter p (cdr lst)))
;         (omake-filter p (cdr lst)))
;     nil))

(defun omake-filter-rev (p lst)
  (let ((res nil))
    (mapcar (lambda (x) (if (funcall p x) (setq res (cons x res)))) lst)
    res))

(defun omake-filter (p lst)
  (reverse (omake-filter-rev p lst)))
  
(defun omake-filter-map (p lst)
  (if lst
      (let ((x (funcall p (car lst))))
        (if x (cons x (omake-filter-map p (cdr lst)))
          (omake-filter-map p (cdr lst))))
    nil))

(defvar omake-buffers nil)
(defun omake-round-buffers ()
  (if omake-buffers 
      (let ((res (car omake-buffers)))
        (setq omake-buffers (cdr omake-buffers))
        res)
    (setq omake-buffers 
          (omake-filter (lambda (buf) 
                          (string-match "\\*omake\\*" (buffer-name buf)))
                        (buffer-list)))
    (if omake-buffers (omake-round-buffers))))

(defvar omake-current-buffer "")

(defun omake-display-buffer (buf)
  (interactive)
  (display-buffer buf)
  (setq omake-current-buffer buf))

(defun omake-round-visit-buffer ()
  (interactive)
  (let ((buf (omake-round-buffers)))
    (if buf (omake-display-buffer buf))
    buf))

(defun omake-set-font-lock ()
  (setq font-lock-defaults 
        '(omake-font-lock-keywords t ; keyword only
                                   nil nil nil))
  (font-lock-mode 1))

(defun omake-create-buffer ()
  (let ((buffer-name (buffer-name (generate-new-buffer omake-buffer-name))))
    (set-buffer buffer-name)
    (omake-mode)
    (omake-set-font-lock)
    (make-local-variable 'last-progress-point)
    (setq last-progress-point nil)
    (make-local-variable 'remained-output)
    (setq remained-output nil)
    (make-local-variable 'last-line-was-end-of-build)
    (setq last-line-was-end-of-build nil)
    (make-local-variable 'no-error)
    (setq no-error t)
    buffer-name))

(defun omake-play-sound (file)
  (start-process "omake-sound" omake-misc-buffer-name "aplay" file))

(defun omake-insert-line (string)
  (save-excursion
    (goto-char (point-max))
    ; (insert-before-markers string)
    (insert string)
    ))

(defun omake-insert-progress (string)
  (save-excursion
    (goto-char (point-max))
    (setq last-progress-point (point))
    ; (insert-before-markers string)
    (insert string)))

(defun omake-process-filter (process output)
  (save-current-buffer
    (let ((buffer-name (process-name process)))
      (set-buffer buffer-name)

      ;; concat remained output
      (if remained-output
          (setq output (concat remained-output output)))
      (setq remained-output nil)

      ;; if we print progress meter in the last call, delete it
      (if last-progress-point
          (save-excursion
            (delete-region last-progress-point (point-max))))

      ;; fix  => \n
      (while (string-match "" output) 
        (setq output (replace-match "\n" t nil output)))

      (let ((last-progress-meter nil))

        ;; remove progress meter string from log
        (while (string-match omake-progress-regexp output)
          ;; set the match to last-progress-meter
          (setq last-progress-meter (match-string 0 output))
          (setq output (replace-match "" t nil output)))

        ;; print output per line
        (while (string-match ".*\n" output)

          ;; clear if a new make started
          (if last-line-was-end-of-build (erase-buffer))

          ;; get the line
          (setq line (match-string 0 output))
          (setq output (substring output (match-end 0)))
          ;; and print 
          (omake-insert-line line)

          ;; error / warning lines
          (if (string-match omake-error-regexp line)
              (progn
                (omake-play-sound omake-sound-error)
                (setq no-error nil)
                (omake-display-buffer buffer-name)))

          ;; locked
          (if (string-match omake-locked-regexp line)
              (progn
                (omake-play-sound omake-sound-error)
                (setq no-error nil)
                (omake-display-buffer buffer-name)))

          (if (string-match omake-rebuild-regexp line)
              (progn
                (omake-play-sound omake-sound-start)))
                
          ;; find the end of build
          (setq last-line-was-end-of-build
                (string-match "\\*\\*\\* omake: polling for filesystem changes" line))
          (if last-line-was-end-of-build
              (progn
                (omake-insert-line "OMAKE IS WAITING YOUR CHANGE")
                (if no-error
                    (omake-play-sound omake-sound-success))
                (setq no-error t)
                (omake-display-buffer buffer-name)))
          )
      
        ;; if something left, it is not ended with \n. Keep it
        (setq remained-output output)

        ;; if last-progress-meter is not "", print it
        (setq last-progress-point nil)
        (if last-progress-meter
            (progn
              (omake-insert-progress last-progress-meter)))))))

(defun omake-find-file-existing (path)
  (if (file-exists-p path)
      (find-file path) ; CR find-file-literary ?
    (message "ERROR: source file %s was not found" path)))

(defun omake-display-error (dir file line char-start char-end)
  (let 
      ((path (concat (file-name-as-directory dir) file)))
    (message path)
    (setq target-buffer (omake-find-file-existing path))
    (if target-buffer
        (progn 
          (goto-line line)
          (let* 
              ((char-of-line (line-beginning-position))
               (char-of-start (+ char-of-line char-start))
               (char-of-end (+ char-of-line char-end)))
            (omake-display-overlay-source (current-buffer) char-of-start char-of-end)
            (goto-char char-of-start))))))

(defun omake-jump-error (next)
  (if (get-buffer omake-current-buffer)
      (progn 
        (set-buffer omake-current-buffer)
        (display-buffer omake-current-buffer)
        (let ((found-start -1)
              (found-end -1)
              (dir "")
              (file "")
              (line "")
              (char-start -1)
              (char-end -1)
              (window (get-buffer-window (current-buffer))))
          (if (progn
                (if 
                    (if next
                        (re-search-forward "^File \"\\(.*\\)\", line \\([0-9]+\\), characters \\([0-9]+\\)-\\([0-9]+\\)" 
                                           nil ; CR BOUND can be used to avoid the summary 
                                           t ; ignore not found error and return simply nil
                                           )
                      (re-search-backward "^File \"\\(.*\\)\", line \\([0-9]+\\), characters \\([0-9]+\\)-\\([0-9]+\\)" 
                                          nil t))
                    (progn
                      (setq found-start (match-beginning 0))
                      (setq found-end (match-end 0))
                      (setq file (match-string 1))
                      (setq line (string-to-int (match-string 2)))
                      (setq char-start (string-to-int (match-string 3)))
                      (setq char-end (string-to-int (match-string 4)))
                      (set-window-point window (if next found-end found-start))
                      (save-excursion
                        (if (re-search-backward "Entering directory `\\(.*\\)'" nil t)
                            (progn 
                              (setq dir (match-string 1))
                              t)
                          (progn 
                            (message "Error message found but no directory info")
                            nil))))
                  (progn
                    (message "No more error found")
                    (delete-overlay omake-overlay-log)
                    (delete-overlay omake-overlay-source)
                    nil)))
              (progn ; search successful: highlight the error line
                (save-current-buffer (omake-display-error dir file line char-start char-end))
                (omake-display-overlay-log (current-buffer) found-start found-end)
                ))))
    (message "no omake buffer selected")))

(defun omake-next-error () 
  (interactive)
  (omake-jump-error t))

(defun omake-previous-error () 
  (interactive)
  (omake-jump-error nil))

(defun omake-mode ()
  (interactive)
  (setq major-mode 'omake-mode)
  (setq mode-name "omake mode"))

(defun omake-run ()
  (interactive)
  (save-current-buffer
    (setq debug-on-error t)
    (let* ((buffer (omake-create-buffer))
           (process 
            (start-process-shell-command buffer buffer 
                                         omake-program-path
                                         omake-program-arguments)))
      (set-process-filter process 'omake-process-filter)
      (omake-display-buffer buffer)
      )))

(provide 'omake-mode)

