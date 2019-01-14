;;; robenkleene-ivy.el --- robenkleene-ivy
;;; Commentary:
;;; Code:

(use-package ivy
  :ensure t
  :bind
  (:map robenkleene/leader-map
        ("l" . swiper)
        ("a" . robenkleene/counsel-rg)
        ("r" . ivy-resume)
        )
  :config
  (defun robenkleene/counsel-rg (dir)
    "Find file recursively in DIR."
    (interactive
     (list
      (if current-prefix-arg
          (read-directory-name "Base directory: ")
        (expand-file-name default-directory)
        )
      )
     )
    (counsel-rg nil dir)
    )
  )

(provide 'robenkleene-ivy)
;;; robenkleene-ivy.el ends here
