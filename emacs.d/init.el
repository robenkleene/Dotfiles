;;; init.el --- init
;;; Commentary:
;;; Code:

;; Reduce the garbage collection threshold, this decreases startup time by ~0.5s
(setq gc-cons-threshold 64000000)
(add-hook 'after-init-hook #'(lambda ()
                               ;; restore after startup
                               (setq gc-cons-threshold 800000)))

;; Commenting this out reduces startup time by 0.5s
;; (require 'package)
;; (setq package-enable-at-startup nil)
;; (setq package-archives '(
;;                          ("gnu" . "https://elpa.gnu.org/packages/")
;;                          ("nongnu" . "https://elpa.nongnu.org/nongnu/")
;;                          ("melpa" . "https://melpa.org/packages/")
;;                          ))
;; (package-initialize)

;; Uncomment to benchmark startup
;; (use-package benchmark-init
;;   :config
;;   ;; To disable collection of benchmark data after init is done.
;;   (add-hook 'after-init-hook 'benchmark-init/deactivate))

;; Setting `file-name-handler-alist' to nil reduces the number of regular
;; expressions that need to run when files are opened, this reduces startup time
;; by ~0.1s
(let ((file-name-handler-alist nil))
  ;; Without this, using `package.el` will add this content to this file
  (setq custom-file "~/.emacs.d/custom.el")
  (load custom-file)

  (add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene"))
  (require 'robenkleene))

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; init.el ends here
