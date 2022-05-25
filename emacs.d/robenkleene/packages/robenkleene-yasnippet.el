;;; robenkleene-yasnippet.el --- yasnippet
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))

(use-package yasnippet
  :commands yas-minor-mode
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
  (yas-reload-all)
  ;; Allow recursive snippet expansion
  (setq yas-triggers-in-field t)
  ;; Support yas in minibuffer
  (add-hook 'minibuffer-setup-hook 'yas-minor-mode)
  (define-key minibuffer-local-map [tab] yas-maybe-expand)
  ;; (define-key minibuffer-local-map [tab] (symbol-function 'yas-maybe-expand))
  ;; Set minibuffer mode as child of `text-mode', so text snippets are available
  ;; in minibuffer mode
  (yas--define-parents 'minibuffer-inactive-mode '(text-mode))
  )

(provide 'robenkleene-yasnippet)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-yasnippet.el ends here
