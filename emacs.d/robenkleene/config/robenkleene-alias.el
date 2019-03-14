;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

;; (defalias 'gcd 'robenkleene/go-to-project-root)
(defun gcd ()
  "The alias keep disappearing so try this as a function."
  (interactive)
  (call-interactively 'robenkleene/go-to-project-root)
  )
(defalias 'tdb 'toggle-debug-on-error)
(defalias 'df 'delete-frame)
(defalias 'rg 'robenkleene/rg)
(defalias 'oi 'robenkleene/edit-init)
(defalias 'osh 'robenkleene/other-window-shell)
(defalias 'os 'robenkleene/open-scratch-other-window)
(defalias 'doc 'robenkleene/documentation)
(defalias 'slug 'robenkleene/slug-project)
(defalias 'tags 'robenkleene/generate-tags)

(provide 'robenkleene-alias)
;;; robenkleene-alias.el ends here
