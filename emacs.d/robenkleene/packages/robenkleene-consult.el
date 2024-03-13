;;; robenkleene-consult.el --- robenkleene-consult
;;; Commentary:
;;; Code:

(use-package consult
  :bind (
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
