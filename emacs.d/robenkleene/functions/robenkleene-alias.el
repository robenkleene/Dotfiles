;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

(defalias 'ei 'edit-init)
(defalias 'yg 'yank-to-grep-buffer)
(defalias 'scw 'rk/source-control-open-web)
(defalias 'scwp (lambda ()
                  (interactive)
                  (rk/source-control-open-web "-p")))
(defalias 'u 'rk/egit-update)
(defalias 'ut 'rk/git-pull-all-text)

(defalias 'esh 'eshell)
(defalias 'yd 'yank-to-diff-buffer)
(defalias 'yl 'yank-to-virtual-dired-buffer)
(defalias 'yg 'yank-to-grep-buffer)

;; vc-mode
(defalias 'vcs (lambda ()
                 (interactive)
                 (vc-dir-root)
                 (forward-paragraph)
                 ))
(defalias 'vcd 'vc-root-diff)
(defalias 'vcl 'vc-print-root-log)
(defalias 'vccd 'vc-cd-vc-root)

;; Vim
;; (defalias 'bd 'kill-this-buffer)
;; (defalias 'new 'rk/switch-to-empty-buffer-other-window)
;; (defalias 'vnew 'rk/switch-to-empty-buffer-other-window-right)
;; (defalias 'enew 'rk/switch-to-empty-buffer)

(defun edit-init ()
  "Edit init."
  (interactive)
  (find-file "~/.emacs.d/robenkleene/robenkleene.el")
  )

(defun rk/source-control-open-web (&optional arg)
  "Open the source control website for the current repository with ARG."
  (interactive)
  (shell-command (concat "~/.bin/source_control_open_site "
                         arg)
                 )
  )

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
