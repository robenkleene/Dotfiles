;;; robenkleene-ivy.el --- robenkleene-ivy
;;; Commentary:
;;; Code:

(use-package ivy
  :ensure t
  :config
  :bind
  (:map robenkleene/leader-map
        ("l" . swiper)
        ("C-l" . swiper)
        ("a" . counsel-rg)
        ("C-a" . counsel-rg)
        ("i" . counsel-imenu)
        ("C-i" . counsel-imenu)
        ("r" . ivy-resume)
        ("C-r" . ivy-resume)
        )
  )

(provide 'robenkleene-ivy)
;;; robenkleene-ivy.el ends here
