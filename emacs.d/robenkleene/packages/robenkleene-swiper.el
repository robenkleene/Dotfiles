;;; robenkleene-swiper.el --- robenkleene-swiper
;;; Commentary:
;;; Code:

(require 'use-package)

(use-package swiper
  :ensure t
  :bind (("C-c l" . swiper))
  )

(provide 'robenkleene-swiper)
;;; robenkleene-swiper.el ends here
