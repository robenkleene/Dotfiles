;;; robenkleene-swiper.el --- robenkleene-swiper
;;; Commentary:
;;; Code:

(require 'use-package)

(use-package swiper
  :ensure t
  :bind (("C-c l" . swiper))
  :config
  (progn
    (define-key ivy-minibuffer-map (kbd "C-w") 'ivy-yank-word)
    )
  )

(provide 'robenkleene-swiper)
;;; robenkleene-swiper.el ends here
