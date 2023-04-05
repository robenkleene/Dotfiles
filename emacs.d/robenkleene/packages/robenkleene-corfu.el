;;; robenkleene-corfu.el --- robenkleene-corfu
;;; Commentary:
;;; Code:

;; Enable Corfu completion UI
;; See the Corfu README for more configuration tips.
(use-package corfu
  :bind (:map corfu-map
              ;; Disable return so that `ls<ret>' on Terminal enters the command
              ;; ("RET" . nil)
              ;; Fix conflict between `yas' and `corfu'
              ("TAB" . nil)
              ("C-y" . corfu-complete)
              )
  :init
  (use-package corfu-terminal)
  (use-package cape
    :init
    ;; Don't add here because it interferes with text modes
    ;; (add-to-list 'completion-at-point-functions #'cape-dabbrev)
    (add-to-list 'completion-at-point-functions #'cape-file)
    ;;(add-to-list 'completion-at-point-functions #'cape-history)
    ;; Programming language symbol
    ;; (add-to-list 'completion-at-point-functions #'cape-keyword)
    ;; Elisp symbol
    ;; (add-to-list 'completion-at-point-functions #'cape-symbol)
    ;;(add-to-list 'completion-at-point-functions #'cape-tex)
    ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
    ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
    ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
    ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
    ;;(add-to-list 'completion-at-point-functions #'cape-dict)
    ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
    ;;(add-to-list 'completion-at-point-functions #'cape-line)
    )
  (setq corfu-auto t
        corfu-auto-delay 0
        corfu-auto-prefix 2
        completion-styles '(basic))
  (global-corfu-mode)
  (unless (display-graphic-p)
    (corfu-terminal-mode +1)
    )

  ;; Languages
  (add-hook 'prog-mode-hook (lambda ()
                              ;; This helps complete Emacs symbols that aren't
                              ;; loaded yet (E.g., the name of a WIP function)
                              (setq-local completion-at-point-functions
                                          (cons #'cape-dabbrev
                                                completion-at-point-functions))
                              ))
  ;; eshell
  (add-hook 'eshell-mode-hook
            (lambda ()
              (setq-local corfu-auto nil)
              (corfu-mode)))
  (defun corfu-send-shell (&rest _)
    "Send completion candidate when inside comint/eshell."
    (cond
     ((and (derived-mode-p 'eshell-mode) (fboundp 'eshell-send-input))
      (eshell-send-input))
     ((and (derived-mode-p 'comint-mode)  (fboundp 'comint-send-input))
      (comint-send-input))))
  (advice-add #'corfu-insert :after #'corfu-send-shell)
  ;; The advices are only needed on Emacs 28 and older.
  (when (< emacs-major-version 29)
    ;; Silence the pcomplete capf, no errors or messages!
    (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
    ;; Ensure that pcomplete does not write to the buffer
    ;; and behaves as a pure `completion-at-point-function'.
    (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify))
  )

(provide 'robenkleene-corfu)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-corfu.el ends here
