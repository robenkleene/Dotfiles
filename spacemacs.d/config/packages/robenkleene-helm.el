;;; robenkleene-helm.el --- robenkleene-helm
;;; Commentary:
;;; Code:

;; TODO: Enable compilation mode after performing a helm-ag search

(eval-after-load 'helm
  '(progn
     ;; Truncate long lines
     (defvar helm-truncate-lines)
     (setq helm-truncate-lines t)
     )
  )
;; helm-source-header
(custom-set-faces
 `(helm-swoop-target-word-face ((t (:foreground nil :background nil :bold nil :inherit isearch))))
 `(helm-match ((t (:foreground nil :background nil :bold nil :inherit isearch))))
 `(helm-swoop-target-line-face ((t (:foreground nil :background nil :inherit hl-line))))
 `(helm-ff-directory ((t (:inherit dired-directory))))
 `(helm-ff-dotted-directory ((t (:inherit dired-directory))))
 `(helm-ff-file ((t (:inherit diredp-file-name))))
 `(helm-moccur-buffer ((t (:inherit button))))
 )

(add-hook 'helm-ag-mode-hook (lambda ()
                                  (grep-mode)
                                  ))

(eval-after-load 'helm-swoop
  '(progn
     (defvar helm-swoop-pre-input-function)
     (setq helm-swoop-pre-input-function (lambda () nil))
     )
  )

(provide 'robenkleene-helm)

;;; robenkleene-helm.el ends here
