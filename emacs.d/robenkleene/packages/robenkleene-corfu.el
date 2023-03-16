;;; robenkleene-corfu.el --- robenkleene-corfu
;;; Commentary:
;;; Code:

;; Enable Corfu completion UI
;; See the Corfu README for more configuration tips.
(use-package corfu
  :init
  (use-package corfu-terminal)
  (use-package cape
    :init
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
  )

(provide 'robenkleene-corfu)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-corfu.el ends here
