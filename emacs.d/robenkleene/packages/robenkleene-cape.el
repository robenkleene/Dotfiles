;;; robenkleene-cape.el --- robenkleene-cape
;;; Commentary:
;;; Code:

;; A `t' element in a buffer-local `completion-at-point-functions' means fall
;; through to the global value. But if a completion function is marked as
;; `exclusive', then if it handles a completion, the rest of the functions are
;; skipped. The `cape' completions are not marked as exclusive, but the default
;; ones typically are. So wrap every function in `completion-at-point-functions'
;; with `cape-capf-nonexclusive' for the duration of the `completion-at-point'
;; call. Wrapping at call time rather than in `after-change-major-mode-hook'
;; also covers functions added later by minor modes, and leaves the value of
;; `completion-at-point-functions' itself untouched.
(defun rk/capf-nonexclusive (fn &rest args)
  "Call FN with ARGS, with every CAPF marked non-exclusive.
The `t' element of `completion-at-point-functions' is passed through
untouched, `cape-capf-nonexclusive' would wrap it into a function that
fails with `void-function' when called."
  (let ((completion-at-point-functions
         (mapcar (lambda (capf)
                   (if (eq capf t) t (cape-capf-nonexclusive capf)))
                 completion-at-point-functions)))
    (apply fn args)))

(use-package cape
  :init
  ;; `add-hook' prepends, so these are listed in reverse of the order they run
  ;; in, most specific first and `cape-dabbrev' last as the catch-all`add-hook'
  ;; is used instead of `add-to-list' because `add-to-list' writes to the
  ;; buffer-local value whenever one exists in the current buffer.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-abbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (use-package yasnippet-capf
    :init
    (add-hook 'completion-at-point-functions #'yasnippet-capf)
    )

  (advice-add 'completion-at-point :around #'rk/capf-nonexclusive)
  )

(provide 'robenkleene-cape)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-cape.el ends here
