;;; robenkleene-consult.el --- robenkleene-consult
;;; Commentary:
;;; Code:

(use-package consult
  :bind (
         ;; Use `consult-buffer' because it supports `recentf' by defalt (hit
         ;; `f<space>')
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x t b" . consult-buffer-other-tab)
         ("M-s o" . consult-line)
         ;; Use `consult-line' by default which fuzzy matches lines, and jumps
         ;; to matches
         ("M-s o" . consult-line)
         ;; Use `consult-imenu' by default which automatically jumps to matches
         ("M-g i" . consult-imenu)
         ("M-s g" . consult-ripgrep)
         ("M-s f" . consult-fd)
         (:map dired-mode-map
               ("M-s f" . consult-fd)
               )
         )
  :commands
  (
   consult-theme
   )
  )

(provide 'robenkleene-consult)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-consult.el ends here
