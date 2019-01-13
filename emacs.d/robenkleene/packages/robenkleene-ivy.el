;;; robenkleene-ivy.el --- robenkleene-ivy
;;; Commentary:
;;; Code:

(use-package ivy
  :ensure t
  :config
  :bind
  (:map robenkleene/leader-map
        ("l" . swiper)
        ("a" . counsel-rg)
        ("r" . ivy-resume)
        )
  )

(provide 'robenkleene-ivy)
;;; robenkleene-ivy.el ends here
