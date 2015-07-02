;;; robenkleene-evil-jumper.el --- robenkleene-evil-jumper
;;; Commentary:
;;; Code:


;;; Customize evil jumper to save locations in temporary buffers
(eval-after-load 'evil-jumper
  '(progn

     (defun evil-jumper--jump-to-index (idx)
       (let ((target-list (evil-jumper--get-window-jump-list)))
         (when (and (< idx (length target-list))
                    (>= idx 0))
           (setf (evil-jumper-jump-idx (evil-jumper--get-current)) idx)
           (let* ((place (nth idx target-list))
                  (pos (car place))
                  (file-name (cadr place)))
             (setq evil-jumper--jumping t)
             (if (get-buffer file-name)
                 (switch-to-buffer file-name)
               (if (file-readable-p file-name)
                   (find-file file-name)))
             (setq evil-jumper--jumping nil)
             (goto-char pos)
             (when evil-jumper-auto-center
               (recenter))))))

     (defun evil-jumper--push ()
       "Pushes the current cursor/file position to the jump list."
       (let ((target-list (evil-jumper--get-window-jump-list)))
         (while (> (length target-list) evil-jumper-max-length)
           (nbutlast target-list 1))
         (let ((file-name (buffer-file-name))
               (buffer-name (buffer-name))
               (current-pos (point))
               (first-pos nil)
               (first-file-name nil)
               (excluded nil))
           (when (not file-name)
             (setq file-name buffer-name))
           (when file-name
             (dolist (pattern evil-jumper-ignored-file-patterns)
               (when (string-match-p pattern file-name)
                 (setq excluded t)))
             (unless excluded
               (when target-list
                 (setq first-pos (caar target-list))
                 (setq first-file-name (car (cdar target-list))))
               (unless (and (equal first-pos current-pos)
                            (equal first-file-name file-name))
                 (push `(,current-pos ,file-name) target-list)))))
         (evil-jumper--message "%s %s" (selected-window) (car target-list))
         (evil-jumper--set-window-jump-list target-list)))
     )


  )



;; file-readable-p
;; (get-buffer "*scratch*")



(provide 'robenkleene-evil-jumper)

;;; robenkleene-evil-jumper.el ends here
