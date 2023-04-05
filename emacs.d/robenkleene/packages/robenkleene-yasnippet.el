;;; robenkleene-yasnippet.el --- yasnippet
;;; Commentary:
;;; Code:

(eval-when-compile
  (unless (bound-and-true-p package--initialized)
    (package-initialize))
  (require 'use-package))
(use-package yasnippet
  :diminish (yas-minor-mode)
  :bind (:map snippet-mode-map
              ("C-c C-k" . yas-abort-snippet))
  :init
  ;; (add-hook 'prog-mode-hook #'yas-minor-mode)
  ;; (add-hook 'markdown-mode-hook '(lambda()
  ;;                                  ;; This solution breaks `tab' in `markdown-mode'
  ;;                                  ;; Disable `markdown-mode-map' tab key
  ;;                                  ;; (define-key markdown-mode-map (kbd "C-i") nil)
  ;;                                  (yas-minor-mode)
  ;;                                  )
  ;;           )
  (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  ;; Allow recursive snippet expansion
  (setq yas-triggers-in-field t)
  ;; Support yas in minibuffer
  ;; This just isn't worth it, breaks too many things
  ;; (add-hook 'minibuffer-setup-hook
  ;;           (lambda ()
  ;;             (yas-minor-mode)
  ;;             ;; (local-set-key (kbd "TAB") 'yas-expand)
  ;;             (local-set-key (kbd "TAB") (symbol-function 'yas-maybe-expand))
  ;;             )
  ;;           )
  ;; Original implementation that stopped working:
  ;; (add-hook 'minibuffer-setup-hook 'yas-minor-mode)
  ;; (define-key minibuffer-local-map [tab] yas-maybe-expand)
  ;; (define-key minibuffer-local-map "M-o"  (lambda ()
  ;;                                      (debug)
  ;;                                      (message "got here")
  ;;                                      (yas-maybe-expand)))
  ;; (define-key minibuffer-local-map [tab] (symbol-function 'yas-maybe-expand))
  ;; Set minibuffer mode as child of `text-mode', so text snippets are available
  ;; in minibuffer mode
  ;; (yas--define-parents 'minibuffer-inactive-mode '(text-mode))
  (yas--define-parents 'minibuffer-mode '(text-mode))
  )

(provide 'robenkleene-yasnippet)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-yasnippet.el ends here
