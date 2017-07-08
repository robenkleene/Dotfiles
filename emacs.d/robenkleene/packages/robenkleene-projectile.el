;;; robenkleene-projectile.el --- robenkleene-projectile
;;; Commentary:
;;; Code:

(require 'use-package)


(use-package projectile
  :ensure t
  ;; :after evil bind-map
  :bind (:map evil-motion-state-map
              ("M-e" . projectile-find-file-dwim)
              ("M-c" . projectile-find-dir)              
              )
  :bind (:map robenkleene/leader-map
              ("f" . projectile-find-file-dwim)
              ("c" . projectile-find-dir)
              )
  ;; `helm-projectile-ag' should do project level `rg' by default, but it isn't
  ;; compatible with `rg', so instead this is currently done with a function
  ;; using `helm-do-ag' with `projectile-project-root'
  ;; :init
  ;; (use-package helm-projectile
  ;;   :ensure t
  ;;   :bind (:map robenkleene/leader-map
  ;;               ("a" . helm-projectile-ag)
  ;;               )
  ;;   )
  )


;; (define-key evil-motion-state-map (kbd "M-e") '(lambda () (interactive)
;;                                                  (projectile-find-file-in-directory default-directory)))
;; (define-key robenkleene/leader-map (kbd "f") 'projectile-find-file-in-directory)
;; (define-key robenkleene/leader-map (kbd "f") '(lambda () (interactive)
;;                                                 (projectile-find-file-in-directory default-directory)))
;; (define-key robenkleene/leader-map (kbd "c") 'projectile-find-dir)

(provide 'robenkleene-projectile)
;;; robenkleene-projectile.el ends here
